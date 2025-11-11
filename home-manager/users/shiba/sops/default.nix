{ localFlakeInputs, ... }:

{
  config,
  ...
}:
{
  imports = [
    localFlakeInputs.sops-nix.homeManagerModules.sops
  ];

  planet.persistence = {
    directories = [
      ".config/sops"
    ];
  };

  sops = {
    age.keyFile = "/persist/home/shiba/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      gh_hosts = {
        mode = "0600";
        path = "${config.xdg.configHome}/gh/hosts.yml";
      };
      glab_config = {
        mode = "0600";
        path = "${config.xdg.configHome}/glab-cli/config.yml";
      };
      syncthing-gui-password = {
        sopsFile = ./syncthing/gui_password.yaml;
        mode = "0600";
      };
      syncthing-cert = {
        format = "binary";
        sopsFile = ./syncthing/cert.pem.sops;
        mode = "0644";
      };
      syncthing-key = {
        format = "binary";
        sopsFile = ./syncthing/key.pem.sops;
        mode = "0600";
      };
    };
  };
}
