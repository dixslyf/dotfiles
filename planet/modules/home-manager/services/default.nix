_: {
  imports = [
    ./flameshot
    ./gpg-agent
    ./mullvad-vpn
    ./picom
    ./polybar
    ./redshift
    ./syncthing
    ./udiskie
    ./wlsunset
  ];

  systemd.user.startServices = "sd-switch";
  services = {
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };
}
