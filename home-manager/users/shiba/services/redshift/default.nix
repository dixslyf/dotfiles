{ config
, lib
, ...
}: {
  services.redshift = {
    enable = true;
    dawnTime = "07:00";
    duskTime = "19:00";
  };

  # run only in bspwm
  systemd.user.services.redshift = {
    Unit.After = lib.mkForce [ "bspwm-session.target" ];
    Unit.PartOf = lib.mkForce ([ "bspwm-session.target" ] ++ lib.optional (config.services.redshift.provider == "geoclue2") "geoclue-agent.service");
    Install.WantedBy = lib.mkForce [ "bspwm-session.target" ];
  };
}
