{...}: {
  imports = [
    ./polybar
    ./redshift
    ./wlsunset
    ./mullvad-vpn
    ./flameshot
    ./gpg-agent
    ./syncthing
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
