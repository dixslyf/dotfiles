{
  config,
  lib,
  pkgs,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption mkPackageOption;
    in
    {
      planet.logseq = {
        enable = mkEnableOption "planet logseq";
        package = mkPackageOption pkgs "logseq" {
          nullable = true;
          extraDescription = "Set to null to only configure persistence.";
        };
      };
    };

  config =
    let
      cfg = config.planet.logseq;
      inherit (lib) mkIf optional;
    in
    mkIf cfg.enable {
      home.packages = optional (cfg.package != null) cfg.package;

      planet.persistence = {
        directories = [
          ".logseq"
          ".config/Logseq"
        ];
      };
    };
}
