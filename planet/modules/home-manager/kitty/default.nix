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
      planet.kitty = {
        enable = mkEnableOption "planet kitty";
      };
    };
  config =
    let
      cfg = config.planet.kitty;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ pers-pkgs.iosevka-term-custom ];
      programs.kitty = {
        enable = true;
        settings = {
          shell = "fish";
          window_margin_width = "12 24";
        };
        font = {
          name = "Iosevka Term Custom";
          size = 16;
        };
        theme = "Catppuccin-Macchiato";
      };
    };
}
