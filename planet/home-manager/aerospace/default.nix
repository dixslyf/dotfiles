{
  config,
  pkgs,
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
        extraConfig = builtins.readFile (
          pkgs.replaceVars ./aerospace.toml {
            wezterm = "${pkgs.wezterm}/bin/wezterm";
          }
        );
      };
    };
}
