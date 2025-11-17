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
      planet.aerospace = {
        enable = mkEnableOption "planet aerospace";
      };
    };

  config =
    let
      cfg = config.planet.aerospace;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.aerospace = {
        enable = true;
        launchd.enable = true;
        userSettings = {
          automatically-unhide-macos-hidden-apps = true;
        };
        extraConfig = builtins.readFile ./aerospace.toml;
      };
    };
}
