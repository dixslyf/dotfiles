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
      planet.udiskie = {
        enable = mkEnableOption "planet udiskie";
      };
    };

  config =
    let
      cfg = config.planet.udiskie;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.udiskie = {
        enable = true;
        automount = true;
        notify = true;
        tray = "auto";
      };

      # For CLI tools like `udiskie-mount`.
      home.packages = with pkgs; [ udiskie ];
    };
}

