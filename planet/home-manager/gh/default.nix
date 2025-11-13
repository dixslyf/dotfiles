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
      planet.gh = {
        enable = mkEnableOption "planet gh";
      };
    };

  config =
    let
      cfg = config.planet.gh;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.gh = {
        enable = true;
        settings.git_protocol = "ssh";
      };
    };
}
