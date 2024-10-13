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
      planet.podman = {
        enable = mkEnableOption "planet podman";
      };
    };

  config =
    let
      cfg = config.planet.podman;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
      };

      hardware.nvidia-container-toolkit.enable = true;
      environment.systemPackages = with pkgs; [
        nvidia-container-toolkit
      ];

      planet.persistence = {
        directories = [
          "/var/lib/containers"
        ];
      };
    };
}
