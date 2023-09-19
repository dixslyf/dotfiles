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
      home.packages = with pkgs; [ logseq ];

      planet.persistence = {
        directories = [
          ".logseq"
          ".config/Logseq"
        ];
      };
    };
}
