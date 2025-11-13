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
      planet.nvidia = {
        enable = mkEnableOption "planet nvidia";
      };
    };

  config =
    let
      cfg = config.planet.nvidia;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      # Required for nvidia prime
      services.xserver.videoDrivers = [ "nvidia" ];
      environment.systemPackages = [ pkgs.pers-pkgs.nvidia-offload ];
    };
}
