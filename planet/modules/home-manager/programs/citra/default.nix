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
      planet.citra = {
        enable = mkEnableOption "planet citra";
      };
    };

  config =
    let
      cfg = config.planet.citra;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ pers-pkgs.citra-nightly ];
      planet.persistence = {
        directories = [
          ".config/citra-emu"
          ".local/share/citra-emu"
        ];
      };
    };
}
