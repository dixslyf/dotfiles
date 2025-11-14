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
      planet.qmk = {
        enable = mkEnableOption "planet qmk";
      };
    };

  config =
    let
      cfg = config.planet.qmk;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        qmk
        via
      ];

      services.udev.packages = with pkgs; [
        qmk-udev-rules
        via
      ];
    };
}
