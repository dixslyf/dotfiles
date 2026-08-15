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
      planet.claude-code = {
        enable = mkEnableOption "planet claude-code";
      };
    };

  config =
    let
      cfg = config.planet.claude-code;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        claude-code
      ];

      planet.persistence = {
        directories = [
          ".claude"
        ];
      };
    };
}
