{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.syncthing = {
        enable = mkEnableOption "planet syncthing";
        host = mkOption {
          type = types.enum [ "alpha" ];
          description = "The host name, which along with the username, specifies which syncthing configuration to use";
        };
      };
    };

  config =
    let
      cfg = config.planet.syncthing;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.syncthing = {
        enable = true;
      };

      systemd.user.services.syncthing.Unit.After = [ "sops-nix.service" ];

      sops.secrets.syncthing-config = {
        format = "binary";
        sopsFile = ./${cfg.host}/${config.home.username}/config.xml;
        mode = "0600";
        path = "${config.xdg.configHome}/syncthing/config.xml";
      };

      sops.secrets.syncthing-cert = {
        format = "binary";
        sopsFile = ./${cfg.host}/${config.home.username}/cert.pem;
        mode = "0644";
        path = "${config.xdg.configHome}/syncthing/cert.pem";
      };

      sops.secrets.syncthing-key = {
        format = "binary";
        sopsFile = ./${cfg.host}/${config.home.username}/key.pem;
        mode = "0600";
        path = "${config.xdg.configHome}/syncthing/key.pem";
      };
    };
}
