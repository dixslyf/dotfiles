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
    in
    mkIf cfg.enable (mkMerge [
      {
        home.packages = with pkgs; [
          pers-pkgs.iosevka-term-custom
        ];

        programs.ghostty = {
          enable = true;
          inherit (cfg) package;
          settings = {
            font-family = "Iosevka Term Custom";
            window-title-font-family = "Iosevka Custom";
            font-size = 16;

            theme = "Catppuccin Macchiato";

            command =
              if config.planet.zellij.enable then
                # Zellij doesn't seem to make the shell start as a login shell by default,
                # and Ghostty itself (unlike Wezterm) also doesn't seem to inherit the environment from the login shell
                # so we need to start Zellij with a bash login shell to inherit the right environment.
                ''bash -l -c "${pkgs.zellij}/bin/zellij"''
              else
                "${pkgs.fish}/bin/fish -l";

            shell-integration = "fish";

            window-padding-x = 24;
            window-padding-y = 16;
            window-decoration = if pkgs.stdenv.hostPlatform.isDarwin then "auto" else "none";

            copy-on-select = "clipboard";

            quit-after-last-window-closed = true;

            auto-update = "off";

            keybind =
              let
                cmod = if pkgs.stdenv.hostPlatform.isDarwin then "cmd" else "ctrl";
              in
              [
                "clear"
                "${cmod}+shift+r=reload_config"
                "${cmod}+shift+p=toggle_command_palette"
                "${cmod}+shift+c=copy_to_clipboard"
                "${cmod}+shift+v=paste_from_clipboard"
                "${cmod}+equal=increase_font_size:1"
                "${cmod}++=increase_font_size:1"
                "${cmod}+-=decrease_font_size:1"
                "${cmod}+0=reset_font_size"
              ];

            custom-shader-animation = "always";
            custom-shader = "${./cursor-warp.glsl}";
          };
        };
      }

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
