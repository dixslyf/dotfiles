{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.direnv = {
        enable = mkEnableOption "planet direnv";
      };
    };

  config =
    let
      cfg = config.planet.direnv;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      planet.persistence = {
        directories = [
          ".local/share/direnv"
        ];
      };
    };
}
