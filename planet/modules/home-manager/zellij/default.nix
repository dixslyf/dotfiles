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
      planet.zellij = {
        enable = mkEnableOption "planet zellij";
      };
    };

  config =
    let
      cfg = config.planet.zellij;
      inherit (lib) mkIf;

    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        zellij
      ];

      planet.persistence = {
        directories = [
          ".cache/zellij"
        ];
      };

      xdg.configFile."zellij/config.kdl".source = ./config.kdl;
    };
}
