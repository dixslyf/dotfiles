{ localFlake', ... }:
{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.mako = {
        enable = mkEnableOption "planet mako";
      };
    };

  config =
    let
      cfg = config.planet.mako;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [ localFlake'.packages.mali ];
      services.mako = {
        enable = true;
        anchor = "bottom-right";
        defaultTimeout = 8000;
        font = "Mali 16";
        maxIconSize = 48;
        width = 400;
        height = 200;
        margin = "12";
        padding = "16";
        borderRadius = 4;
        borderSize = 3;
        extraConfig = builtins.readFile "${localFlake'.packages.catppuccin-mako}/share/mako/themes/catppuccin/macchiato";
      };
    };
}
