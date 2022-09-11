{ ... }:

{
  # Note that xsession.enable = false so that home-manager doesn't create ~/.xsession.
  # More details: https://github.com/NixOS/nixpkgs/issues/190442
  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      eDP-1 = [ "p1" "p2" "p3" "p4" "p5" "p6" "p7" "p8" "p9" "p0" ];
      HDMI-1 = [ "h1" "h2" "h3" "h4" "h5" "h6" "h7" "h8" "h9" "h0" ];
    };
    settings = {
      border_width = 2;
      normal_border_color = "#969896";
      active_border_color = "#81a2be";
      focused_border_color = "#b294bb";
      window_gap = 12;
      gapless_monocle = true;
      borderless_monocle = true;
      single_monocle = true;
      focus_follows_pointer = true;
      pointer_follows_focus = true;
      pointer_follows_monitor = true;
    };
  };

  # home-manager starts sxhkd through ~/.xsession, but since xsession.enable = false,
  # the NixOS module for bspwm must be enabled in order for sxhkd to start (through
  # the none+bspwm.desktop file, and yes, the module for bspwm starts sxhkd with
  # seemingly no option not to even though sxhkd is separate from bspwm).
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Escape" = "pkill -USR1 -x sxhkd"; # reload sxhkd config
      "super + shift + {q,r}" = "bspc {quit,wm -r}"; # quit / restart bspwm
      "super + {shift,ctrl} + c" = "bspc node -{c,k}"; # close / kill window
      "super + {_,shift} + {j,k}" = ''bspc node -{f,s} {next,prev}.local.!hidden.window''; # focus / move window
      "super + {1-9,0} + {_,shift}" = ''num={1-9,10}; if [ $(bspc query -D -d focused --names | cut -c 2) != "$num" ]; then bspc {desktop -f,node -d} focused:^"$num"; fi''; # focus / move window to desktop

      "super + Return" = "kitty -1"; # open kitty
      "{XF86MonBrightnessUp,XF86MonBrightnessDown} + {_,shift}" = "light -{A,U} {0.2,1}";
      "super + {XF86AudioRaiseVolume,XF86AudioLowerVolume} + {_,shift}" = "light -{A,U} {0.2,1}";
      "{XF86AudioRaiseVolume,XF86AudioLowerVolume} + {_,shift}" = "pamixer -{i,d} {1,2}";
    };
  };
}
