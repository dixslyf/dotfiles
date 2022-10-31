{config, ...}: {
  sops.secrets."user-passwords/shiba" = {
    neededForUsers = true;
    sopsFile = ../secrets.yaml;
  };

  users = {
    users = {
      shiba = {
        isNormalUser = true;
        extraGroups = ["networkmanager" "video" "wheel"];
        passwordFile = config.sops.secrets."user-passwords/shiba".path;
      };
    };
  };

  home-manager = {
    users = {
      shiba = import ./home.nix;
    };
  };

  sops.secrets.syncthing-config = {
    format = "binary";
    sopsFile = ./services/syncthing/config.xml;
    mode = "0600";
    owner = config.users.users.shiba.name;
    group = config.users.users.shiba.group;
  };

  sops.secrets.syncthing-cert = {
    format = "binary";
    sopsFile = ./services/syncthing/cert.pem;
    mode = "0644";
    owner = config.users.users.shiba.name;
    group = config.users.users.shiba.group;
  };

  sops.secrets.syncthing-key = {
    format = "binary";
    sopsFile = ./services/syncthing/key.pem;
    mode = "0600";
    owner = config.users.users.shiba.name;
    group = config.users.users.shiba.group;
  };
}
