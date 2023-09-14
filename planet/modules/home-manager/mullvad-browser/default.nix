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
      planet.mullvad-browser = {
        enable = mkEnableOption "planet mullvad-browser";
      };
    };

  config =
    let
      cfg = config.planet.mullvad-browser;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        mullvad-browser
      ];

      planet.persistence = {
        directories = [ ".mullvad" ];
      };
    };
}
