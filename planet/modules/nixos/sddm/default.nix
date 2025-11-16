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
        pkgs.pers-pkgs.iosevka-custom
      ];

      environment.systemPackages = with pkgs; [
        (catppuccin-sddm.override {
          flavor = "macchiato";
          font = "Iosevka Custom";
          fontSize = "12";
        })
      ];

      services.displayManager.sddm = {
        enable = true;
        package = pkgs.qt6Packages.sddm;
        theme = "catppuccin-macchiato-mauve";
      };
    };
}
