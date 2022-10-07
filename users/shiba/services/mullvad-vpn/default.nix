{pkgs, ...}: {
  systemd.user.services.mullvad-vpn = {
    Unit = {
      Description = "Mullvad VPN GUI";
      Requires = ["tray.target"];
      After = ["graphical-session-pre.target" "tray.target"];
      PartOf = ["graphical-session.target"];
    };
    Install = {WantedBy = ["graphical-session.target"];};
    Service = {ExecStart = "${pkgs.mullvad-vpn}/bin/mullvad-vpn";};
  };
}
