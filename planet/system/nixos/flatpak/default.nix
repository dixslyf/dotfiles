{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.flatpak = {
        enable = mkEnableOption "planet flatpak";
      };
    };

  config =
    let
      cfg = config.planet.flatpak;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.flatpak = {
        enable = true;
      };

      planet.persistence = {
        directories = [ "/var/lib/flatpak" ];
      };
    };
}
