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
        mkMerge
        ;
    in
    mkIf cfg.enable (mkMerge [
      {
        virtualisation.podman = {
          enable = true;
        };

        planet.persistence = {
          directories = [
            "/var/lib/containers"
          ];
        };
      }

      # Only enable docker compatibility if docker is not enabled to avoid conflicts.
      (mkIf (!config.virtualisation.docker.enable) {
        virtualisation.podman = {
          dockerCompat = true;
          dockerSocket.enable = true;
        };
      })
    ]);
}
