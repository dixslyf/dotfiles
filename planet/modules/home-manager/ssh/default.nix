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
      planet.ssh = {
        enable = mkEnableOption "planet ssh";
      };
    };

  config =
    let
      cfg = config.planet.ssh;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
      };
      planet.persistence = {
        directories = [ ".ssh" ];
      };
    };
}
