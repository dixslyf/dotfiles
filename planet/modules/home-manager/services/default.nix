_: {
  imports = [
    ./flameshot
    ./gpg-agent
    ./mullvad-vpn
    ./network-manager-applet
    ./picom
    ./polybar
    ./redshift
    ./syncthing
    ./udiskie
    ./wlsunset
  ];

  systemd.user.startServices = "sd-switch";
  services = {
    blueman-applet.enable = true;
  };
}
