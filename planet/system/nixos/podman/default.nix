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
        types
        mkOption
        mkEnableOption
        ;
    in
    {
      planet.podman = {
        enable = mkEnableOption "planet podman";
        nvidia-container-toolkit = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Whether to configure nvidia-container-toolkit.
          '';
        };
      };
    };

  config =
    let
      cfg = config.planet.podman;
      inherit (lib)
        mkMerge
        mkIf
        ;
    in
    mkIf cfg.enable (mkMerge [
      {
        virtualisation.podman = {
          enable = true;
          dockerCompat = true;
          dockerSocket.enable = true;
        };

        planet.persistence = {
          directories = [
            "/var/lib/containers"
          ];
        };
      }
      (mkIf cfg.nvidia-container-toolkit {
        hardware.nvidia-container-toolkit.enable = true;
        environment.systemPackages = with pkgs; [
          nvidia-container-toolkit
        ];
      })
    ]);
}
