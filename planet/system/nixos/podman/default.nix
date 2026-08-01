{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib)
        mkEnableOption
        ;
    in
    {
      planet.podman = {
        enable = mkEnableOption "planet podman";
      };
    };

  config =
    let
      cfg = config.planet.podman;
      inherit (lib)
        mkIf
        ;
    in
    mkIf cfg.enable {
      virtualisation.podman = {
        enable = true;
      };

      planet.persistence = {
        directories = [
          "/var/lib/containers"
        ];
      };
    };
}
