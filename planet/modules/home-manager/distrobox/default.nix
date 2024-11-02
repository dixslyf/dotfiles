{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.planet.distrobox;
in
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      # Note: Podman must be enabled on the host!
      planet.distrobox = {
        enable = mkEnableOption "planet distrobox";
      };
    };

  config =
    let
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [ pkgs.distrobox ];
      planet.persistence = {
        directories = [
          ".local/share/containers"
        ];
      };
      xdg.configFile."distrobox/distrobox.conf" = {
        source = ./distrobox.conf;
      };
    };
}
