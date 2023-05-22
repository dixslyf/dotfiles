{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.papis = {
        enable = mkEnableOption "planet papis";
      };
    };

  config =
    let
      cfg = config.planet.papis;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs = {
        papis = {
          enable = true;
          libraries = {
            papers = {
              name = "Papers";
              isDefault = true;
              settings = {
                dir = "~/Documents/Papers";
              };
            };
          };
        };
      };
    };
}

