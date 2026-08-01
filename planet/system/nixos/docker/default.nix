{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib)
        mkEnableOption
        ;
    in
    {
      planet.docker = {
        enable = mkEnableOption "planet docker";
      };
    };

  config =
    let
      cfg = config.planet.docker;
      inherit (lib)
        mkIf
        ;
    in
    mkIf cfg.enable {
      virtualisation.docker = {
        enable = true;
      };

      planet.persistence = {
        directories = [
          "/var/lib/containers"
        ];
      };
    };
}
