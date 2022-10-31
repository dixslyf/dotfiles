{osConfig, config, ...}: {
  services.syncthing = {
    enable = true;
  };

  xdg.configFile."syncthing/config.xml" = {
    source = config.lib.file.mkOutOfStoreSymlink osConfig.sops.secrets.syncthing-config.path;
  };

  xdg.configFile."syncthing/cert.pem" = {
    source = config.lib.file.mkOutOfStoreSymlink osConfig.sops.secrets.syncthing-cert.path;
  };

  xdg.configFile."syncthing/key.pem" = {
    source = config.lib.file.mkOutOfStoreSymlink osConfig.sops.secrets.syncthing-key.path;
  };
}
