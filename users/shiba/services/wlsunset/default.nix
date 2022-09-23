{pkgs, ...}: {
  imports = [./module.nix];
  services.wlsunset = {
    enable = true;
    package = pkgs.pvtpkgs.wlsunset;
    sunrise = "07:00";
    sunset = "19:00";
    systemdTarget = "hyprland-session.target";
  };
}
