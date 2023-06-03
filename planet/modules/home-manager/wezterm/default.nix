{ localFlake', ... }:
{ config
, lib
, pkgs
, ...
}: {
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
        mkMerge;
    in
    mkIf cfg.enable (mkMerge [
      {
        home.packages = with pkgs; [
          material-design-icons
          localFlake'.packages.iosevka-term-custom
          (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
        ];

        programs.wezterm = {
          enable = true;
        };

        xdg.configFile."wezterm/wezterm.lua".source = pkgs.substituteAll {
          src = pkgs.runCommand "wezterm.lua" { } ''
            ${pkgs.luaPackages.fennel}/bin/fennel --compile ${./wezterm.fnl} > "$out"
          '';
          default_shell = "${pkgs.fish}/bin/fish";
        };
      }

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

