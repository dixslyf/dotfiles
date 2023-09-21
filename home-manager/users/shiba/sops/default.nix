{ localFlakeInputs, ... }:

{ config
, ...
}: {
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
    };
  };
}
