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
        container-toolkit = mkEnableOption "Whether to configure nvidia-container-toolkit.";
      };
    };

  config =
    let
      cfg = config.planet.nvidia;
      inherit (lib)
        mkIf
        mkMerge
        ;
    in
    mkIf cfg.enable (mkMerge [
      {
        # Required for nvidia prime
        services.xserver.videoDrivers = [ "nvidia" ];
        environment.systemPackages = [ pkgs.pers-pkgs.nvidia-offload ];
      }

      (mkIf cfg.container-toolkit {
        hardware.nvidia-container-toolkit.enable = true;
        environment.systemPackages = with pkgs; [
          nvidia-container-toolkit
        ];
      })
    ]);
}
