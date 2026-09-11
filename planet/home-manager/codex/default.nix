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
      planet.codex = {
        enable = mkEnableOption "planet codex";
      };
    };

  config =
    let
      cfg = config.planet.codex;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          codex
        ];

        sessionVariables = {
          CODEX_HOME = "${config.home.homeDirectory}/.config/codex";
        };
      };

      planet.persistence = {
        directories = [
          ".config/codex"
        ];
      };
    };
}
