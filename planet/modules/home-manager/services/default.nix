_: {
  imports = [
    ./flameshot
    ./gpg-agent
    ./mullvad-vpn
    ./picom
    ./polybar
    ./redshift
    ./syncthing
    ./wlsunset
  ];

  systemd.user.startServices = "sd-switch";
  services = {
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
