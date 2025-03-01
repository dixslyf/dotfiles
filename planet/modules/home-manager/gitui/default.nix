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
      planet.gitui = {
        enable = mkEnableOption "planet gitui";
      };
    };

  config =
    let
      cfg = config.planet.gitui;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.gitui = {
        enable = true;
        keyConfig = builtins.readFile ./key_bindings.ron;
        theme = builtins.readFile "${localFlake'.packages.catppuccin-gitui}/share/gitui/catppuccin-macchiato.ron";
      };
    };
}
