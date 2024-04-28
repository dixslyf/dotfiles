{ localFlake', ... }:
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
        localFlake'.packages.sddm-sugar-candy
      ];

      # Disable external monitor
      services.xserver.displayManager.setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off";

      services.displayManager.sddm = {
        enable = true;
        theme = "sugar-candy";
      };
    };
}

