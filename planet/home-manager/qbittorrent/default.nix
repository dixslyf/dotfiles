{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.planet.qbittorrent;
in
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.qbittorrent = {
        enable = mkEnableOption "planet qBittorrent";
      };
    };

  config =
    let
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [
        pkgs.qbittorrent
      ];

      planet.persistence = {
        directories = [
          ".config/qBittorrent"
          ".local/share/qBittorrent"
        ];
      };
    };
}
