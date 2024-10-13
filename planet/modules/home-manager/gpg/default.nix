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
      planet.gpg = {
        enable = mkEnableOption "planet gpg";
      };
    };

  config =
    let
      cfg = config.planet.gpg;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.gpg.enable = true;
      planet.persistence = {
        directories = [ ".gnupg" ];
      };
    };
}
