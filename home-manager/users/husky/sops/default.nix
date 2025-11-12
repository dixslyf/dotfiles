_: {
  planet.persistence = {
    directories = [
      ".config/sops"
    ];
  };

  sops = {
    age.keyFile = "/persist/home/husky/.config/sops/age/keys.txt";
    secrets = {
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
