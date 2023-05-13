{ self' }:
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
      planet.sddm = {
        enable = mkEnableOption "planet sddm";
      };
    };

  config =
    let
      cfg = config.planet.sddm;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        libsForQt5.qt5.qtgraphicaleffects
        libsForQt5.qt5.qtquickcontrols2
        libsForQt5.qt5.qtsvg
      ] ++ [
        self'.packages.sddm-sugar-candy
      ];

      services.xserver = {
        displayManager = {
          # Disable external monitor
          setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off";
          sddm = {
            enable = true;
            theme = "sugar-candy";
          };
        };
      };
    };
}

