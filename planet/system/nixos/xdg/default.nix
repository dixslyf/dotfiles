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
        portal = {
          enable = true;
          extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
          config = {
            # Prefer `xdg-desktop-portal-gtk` for every portal interface.
            # For more information, see: https://github.com/flatpak/xdg-desktop-portal/blob/1.18.1/doc/portals.conf.rst.in
            common = {
              default = [
                "gtk"
              ];
            };
          };
        };
      };
    };
}
