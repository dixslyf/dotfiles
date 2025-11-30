{
  config,
  lib,
  pkgs,
  ...
}:
{
  options =
    let
      inherit (lib)
        mkEnableOption
        mkPackageOption
        ;
    in
    {
      planet.ghostty = {
        enable = mkEnableOption "planet ghostty";
        defaultTerminal = mkEnableOption "ghostty as the default terminal";
        package = mkPackageOption pkgs (
          if pkgs.stdenv.hostPlatform.isDarwin then "ghostty-bin" else "ghostty"
        ) { };
      };
    };

  config =
    let
      cfg = config.planet.ghostty;
      inherit (lib)
        mkIf
        mkMerge
        ;

      mkConfigFile =
        command:
        pkgs.replaceVars ./config {
          inherit command;
          cursor-warp-shader = ./cursor-warp.glsl;
          shell-integration = "fish";
        };
    in
    mkIf cfg.enable (mkMerge [
      {
        home.packages =
          with pkgs;
          [
            pers-pkgs.iosevka-term-custom
          ]
          ++ lib.singleton cfg.package;
      }

      (mkIf config.planet.zellij.enable {
        # Zellij doesn't seem to make the shell start as a login shell by default,
        # and Ghostty itself (unlike Wezterm) also doesn't seem to inherit the environment from the login shell
        # so we need a wrapper to make Zellij inherit the right environment.
        xdg.configFile."ghostty/config".source = mkConfigFile (
          pkgs.writeShellScript "zellij-wrapper" ''
            bash -l -c "${pkgs.zellij}/bin/zellij"
          ''
        );
      })

      (mkIf (!config.planet.zellij.enable) {
        xdg.configFile."ghostty/config".source = mkConfigFile "${pkgs.fish}/bin/fish -l";
      })

      (mkIf cfg.defaultTerminal {
        planet.default-terminal = {
          startCommand = ''
            ${cfg.package}/bin/ghostty "$@"
          '';
          startInDirectoryCommand = ''
            ${cfg.package}/bin/ghostty --working-directory "$@"
          '';
        };
      })
    ]);
}
