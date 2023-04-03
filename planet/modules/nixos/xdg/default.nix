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
      planet.xdg = {
        enable = mkEnableOption "planet xdg";
      };
    };

  config =
    let
      cfg = config.planet.xdg;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      xdg = {
        autostart.enable = true;
        portal = {
          enable = true;
          # xdg-desktop-portal-wlr should already be enabled by hyprland
          extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        };
      };
    };
}



