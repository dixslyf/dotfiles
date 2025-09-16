{ localFlake', ... }:
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
      fonts.packages = [
        localFlake'.packages.iosevka-custom
      ];

      environment.systemPackages = with pkgs; [
        (catppuccin-sddm.override {
          flavor = "macchiato";
          font = "Iosevka Custom";
          fontSize = "12";
        })
      ];

      # Disable external monitor
      services.xserver.displayManager.setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off";

      services.displayManager.sddm = {
        enable = true;
        package = pkgs.qt6Packages.sddm;
        theme = "catppuccin-macchiato-mauve";
      };
    };
}
