{ self' }:
{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.zathura = {
        enable = mkEnableOption "planet zathura";
      };
    };

  config =
    let
      cfg = config.planet.zathura;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [ self'.packages.iosevka-custom ];
      programs.zathura = {
        enable = true;
        options = {
          font = "Iosevka Custom 16";
          recolor = "true";
          selection-clipboard = "clipboard";
        };
        extraConfig = ''
          include ${self'.packages.catppuccin-zathura}/share/zathura/themes/catppuccin-macchiato
        '';
      };
    };
}
