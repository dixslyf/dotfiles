{
  config,
  ...
}:
{
  services.syncthing = {
    enable = true;
  };

  systemd.user.services.syncthing.Unit.After = [ "sops-nix.service" ];

  sops = {
    secrets = {
      syncthing-config = {
        format = "binary";
        sopsFile = ./config.xml;
        mode = "0600";
        path = "${config.xdg.configHome}/syncthing/config.xml";
      };
      syncthing-cert = {
        format = "binary";
        sopsFile = ./cert.pem;
        mode = "0644";
        path = "${config.xdg.configHome}/syncthing/cert.pem";
      };
      syncthing-key = {
        format = "binary";
        sopsFile = ./key.pem;
        mode = "0600";
        path = "${config.xdg.configHome}/syncthing/key.pem";
      };
    };
  };
}
