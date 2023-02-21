{ config
, lib
, pkgs
, ...
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
      colors = "${pkgs.pers-pkgs.catppuccin-polybar}/share/polybar/themes/catppuccin/macchiato.ini";
    };
  };

  # disable the service to prevent polybar from trying to start in wayland
  systemd.user.services.polybar = {
    Unit.PartOf = lib.mkForce [ ];
    Install.WantedBy = lib.mkForce [ ];
  };

  # start in bspwm
  xsession.windowManager.bspwm.startupPrograms = [ config.systemd.user.services.polybar.Service.ExecStart ];

  # sxhxd keybinding to toggle the bar on the current monitor
  services.sxhkd.keybindings =
    let
      toggleScript = pkgs.writeShellScriptBin "toggle-current-polybar" ''
        monitor="$(${pkgs.bspwm}/bin/bspc query -M -m focused --names)"

        if [ "$monitor" = "eDP-1" ]; then
          wm="polybar-eDP-1_eDP-1"
        elif [ "$monitor" = "HDMI-1" ]; then
          wm="polybar-HDMI-1_HDMI-1"
        fi

        state=$(${pkgs.xorg.xwininfo}/bin/xwininfo -name "$wm" | ${pkgs.gnugrep}/bin/grep "Map State" | cut -d " " -f 5)
        if [ "$state" = "IsViewable" ]; then
          ${pkgs.bspwm}/bin/bspc config -m "$monitor" top_padding 0
        elif [ "$state" = "IsUnMapped" ]; then
          ${pkgs.bspwm}/bin/bspc config -m "$monitor" top_padding 40
        fi

        ${pkgs.polybar}/bin/polybar-msg -p "$(${pkgs.xorg.xprop}/bin/xprop -name "$wm" _NET_WM_PID | cut -d " " -f 3)" cmd toggle
      '';
    in
    {
      "super + d" = "${toggleScript}/bin/toggle-current-polybar";
    };
}
