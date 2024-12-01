{ localFlake', ... }:
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.wezterm = {
        enable = mkEnableOption "planet wezterm";
        defaultTerminal = mkEnableOption "wezterm as the default terminal";
      };
    };

  config =
    let
      cfg = config.planet.wezterm;
      inherit (lib)
        mkIf
        mkMerge
        ;

      mkConfigFile =
        default_prog_args:
        let
          substituted = pkgs.substituteAll {
            src = ./wezterm.fnl;
            inherit default_prog_args;
          };
        in
        pkgs.runCommand "wezterm.lua" { } ''
          ${pkgs.luaPackages.fennel}/bin/fennel --compile ${substituted} > "$out"
        '';
    in
    mkIf cfg.enable (mkMerge [
      {
        home.packages = with pkgs; [
          material-design-icons
          localFlake'.packages.iosevka-term-custom
          nerd-fonts.symbols-only
        ];

        programs.wezterm = {
          enable = true;
        };
      }

      (mkIf config.planet.zellij.enable {
        xdg.configFile."wezterm/wezterm.lua".source = mkConfigFile ''"${pkgs.zellij}/bin/zellij"'';
      })

      (mkIf (!config.planet.zellij.enable) {
        xdg.configFile."wezterm/wezterm.lua".source = mkConfigFile ''"${pkgs.fish}/bin/fish" "-l"'';
      })

      (mkIf cfg.defaultTerminal {
        planet.default-terminal = {
          startCommand = ''
            ${config.programs.wezterm.package}/bin/wezterm start -- "$@"
          '';
          startInDirectoryCommand = ''
            ${config.programs.wezterm.package}/bin/wezterm start --cwd "$@"
          '';
        };
      })
    ]);
}
