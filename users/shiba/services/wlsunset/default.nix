{pkgs, ...}: {
  imports = [./module.nix];
  services.wlsunset = {
    enable = true;
    package = pkgs.pers-pkgs.wlsunset;
    sunrise = "07:00";
    sunset = "19:00";
    duration = 60;
    temperature.night = 3400;
    systemdTarget = "hyprland-session.target";
  };
}
