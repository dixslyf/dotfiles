{ lib, ... }: {
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
      };
    };
  };

  systemd.user.services.flameshot = {
    # run only in bspwm
    Unit.PartOf = lib.mkForce [ "bspwm-session.target" ];
    Install.WantedBy = lib.mkForce [ "bspwm-session.target" ];
  };
}
