{
  config,
  lib,
  pkgs,
  ...
}: {
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      pulseSupport = true;
    };
    script = ''
      # Terminate already running bar instances
      ${pkgs.killall}/bin/killall -q polybar

      # Wait until the processes have been shut down
      while ${pkgs.procps}/bin/pgrep -u "$UID" -x polybar >/dev/null; do sleep 1; done

      polybar eDP-1 -r &
      ${pkgs.bspwm}/bin/bspc config -m "eDP-1" top_padding 40

      if [ "$(${pkgs.xorg.xrandr}/bin/xrandr --query | ${pkgs.gnugrep}/bin/grep 'HDMI-1 connected')" != "" ]; then
        polybar HDMI-1 -r &
        ${pkgs.bspwm}/bin/bspc config -m "HDMI-1" top_padding 40
      fi
    '';
    config = pkgs.substituteAll {
      src = ./config;
      colors = "${pkgs.pvtpkgs.catppuccin-polybar}/share/polybar/themes/catppuccin/macchiato.ini";
    };
  };

  # disable the service to prevent polybar from trying to start in wayland
  systemd.user.services.polybar = {
    Unit.PartOf = lib.mkForce [];
    Install.WantedBy = lib.mkForce [];
  };

  # start in bspwm
  xsession.windowManager.bspwm.startupPrograms = [config.systemd.user.services.polybar.Service.ExecStart];
}
