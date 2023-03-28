{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.networkmanager = {
        enable = mkEnableOption "planet network manager";
      };
    };

  config =
    let
      cfg = config.planet.networkmanager;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      networking.networkmanager.enable = true;
      planet.persistence = {
        directories = [
          "/etc/NetworkManager/system-connections"
        ];
      };
    };
}

