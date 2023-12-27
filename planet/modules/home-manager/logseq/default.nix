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
      planet.logseq = {
        enable = mkEnableOption "planet logseq";
      };
    };

  config =
    let
      cfg = config.planet.logseq;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      # FIXME: use package from Nixpkgs once #274180 lands
      home.packages = [ localFlakeInputs'."nixpkgs-logseq-0.10.3".legacyPackages.logseq ];

      planet.persistence = {
        directories = [
          ".logseq"
          ".config/Logseq"
        ];
      };
    };
}
