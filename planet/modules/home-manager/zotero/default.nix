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
      planet.zotero = {
        enable = mkEnableOption "planet zotero";
      };
    };

  config =
    let
      cfg = config.planet.zotero;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ zotero ];

      planet.persistence = {
        directories = [
          "Zotero"
          ".zotero"
        ];
      };
    };
}
