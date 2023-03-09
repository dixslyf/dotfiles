_: {
  imports = [
    ./blueman-applet
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
}
