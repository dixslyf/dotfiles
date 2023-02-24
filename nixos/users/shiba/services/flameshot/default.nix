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
    # the original configuration lists `tray.target` as a requirement,
    # which the below removes
    Unit.Requires = lib.mkForce [ ];
    Unit.After = lib.mkForce [ "bspwm-session.target" ];
    # run only in bspwm
    Unit.PartOf = lib.mkForce [ "bspwm-session.target" ];
    Install.WantedBy = lib.mkForce [ "bspwm-session.target" ];
  };
}
