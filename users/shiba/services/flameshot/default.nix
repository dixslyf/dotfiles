{lib, ...}: {
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
      };
    };
  };

  # disable the service to prevent flameshot from running in wayland sessions
  systemd.user.services.flameshot = {
    Unit.PartOf = lib.mkForce [];
    Install.WantedBy = lib.mkForce [];
  };
}
