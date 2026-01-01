{ localFlakeInputs, ... }:
{
  config,
  lib,
  ...
}:
{
  imports = [
    localFlakeInputs.niri-flake.nixosModules.niri
  ];

  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.niri = {
        enable = mkEnableOption "planet niri";
      };
    };

  config =
    let
      cfg = config.planet.niri;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.niri = {
        enable = true;
      };
    };
}
