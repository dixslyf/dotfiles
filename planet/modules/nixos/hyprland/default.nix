{ inputs }:
{ config
, lib
, ...
}: {
  imports = [ inputs.hyprland.nixosModules.default ];

  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.hyprland = {
        enable = mkEnableOption "planet hyprland";
      };
    };

  config =
    let
      cfg = config.planet.hyprland;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.hyprland = {
        enable = true;
        nvidiaPatches = true;
      };
    };
}

