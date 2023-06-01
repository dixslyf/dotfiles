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
      };
    };

  config =
    let
      cfg = config.planet.wezterm;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
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
    };
}

