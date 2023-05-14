{ localFlakeInputs', ... }:
{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.osu-lazer = {
        enable = mkEnableOption "planet osu-lazer";
      };
    };

  config =
    let
      cfg = config.planet.osu-lazer;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [ localFlakeInputs'.nix-gaming.packages.osu-lazer-bin ];
      planet.persistence = {
        directories = [ ".local/share/osu" ];
      };
    };
}
