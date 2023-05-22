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

      # Dummy `scripts` directory to silence `papis`'s message
      # about creating the `scripts` directory on first run
      # Unfortunately, `home-manager` cannot create empty directories:
      # https://github.com/nix-community/home-manager/issues/2104#issuecomment-861676751
      xdg.configFile."papis/scripts/.keep".source = builtins.toFile "keep" "";
    };
}

