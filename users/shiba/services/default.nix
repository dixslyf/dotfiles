{...}: {
  imports = [./wlsunset];

  systemd.user.startServices = "sd-switch";
  services = {
    gpg-agent = {
      enable = true;
      enableFishIntegration = true;
      enableSshSupport = true;
    };
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "auto";
    };
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };
}
