{
  localFlake,
  ...
}:

{
  config,
  lib,
  pkgs,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.bspwm = {
        enable = mkEnableOption "planet bspwm";
        primaryMonitor = mkOption {
          type = types.str;
          description = "The name of the primary monitor";
        };
      };
    };

  config =
    let
      cfg = config.planet.bspwm;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      # Note that xsession.enable = false so that home-manager doesn't create ~/.xsession.
      # More details: https://github.com/NixOS/nixpkgs/issues/190442
      xsession.windowManager.bspwm = {
        enable = true;
        package = pkgs.pers-pkgs.bspwm;
        monitors = {
          ${cfg.primaryMonitor} = [
            "p1"
            "p2"
            "p3"
            "p4"
            "p5"
            "p6"
            "p7"
            "p8"
            "p9"
            "p0"
          ];
        };
        rules = {
          "Steam" = {
            desktop = "eDP-1:^2";
          };
          "Qutebrowser" = {
            desktop = "eDP-1:^1";
          };
          "Firefox" = {
            desktop = "eDP-1:^4";
          };
          "Zathura" = {
            state = "tiled";
          };
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
        extraConfig = ''
          ${pkgs.systemd}/bin/systemctl --user start bspwm-session.target

          ${pkgs.autorandr}/bin/autorandr --change

          # TODO: figure out how to set this for all X window managers
          ${pkgs.xorg.xsetroot}/bin/xsetroot -cursor_name left_ptr

          # Set wallpaper
          ${pkgs.feh}/bin/feh --bg-scale ${localFlake}/planet/wallpapers/ocean-moon-stars.png
        '';
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
          "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,\~fullscreen}"; # set the window state
          "super + alt + {h,j,k,l}" = ''
            bspc node -z {left -20 0 || bspc node -z right -20 0, \
                          bottom 0 20 || bspc node -z top 0 20,\
                          top 0 -20 || bspc node -z bottom 0 -20,\
                          right 20 0 || bspc node -z left 20 0}
          '';
          "super + {_,shift} + {u,i}" = "bspc {monitor -f,node -m} {prev,next}"; # focus or send to the next monitor
          "super + {1-9,0} + {_,shift}" =
            ''num={1-9,10}; if [ $(bspc query -D -d focused --names | cut -c 2) != "$num" ]; then bspc {desktop -f,node -d} focused:^"$num"; fi''; # focus / move window to desktop
          "super + {o,p}" = "bspc desktop -f {prev,next}.local"; # focus the next/prev desktop in the current monitor
          "super + Return" = "wezterm"; # open terminal
          "{XF86MonBrightnessUp,XF86MonBrightnessDown} + {_,shift}" = "light -{A,U} {0.2,1}";
          "super + {XF86AudioRaiseVolume,XF86AudioLowerVolume} + {_,shift}" = "light -{A,U} {0.2,1}";
          "{XF86AudioRaiseVolume,XF86AudioLowerVolume} + {_,shift}" = "pamixer -{i,d} {1,2}";
          "XF86AudioMute" = "pamixer --toggle-mute";
          "super + r" = "rofi -show drun";
          "super + g" =
            "if [ \"$(bspc config window_gap)\" -eq 0 ]; then bspc config window_gap 12; bspc config border_width 2; else bspc config window_gap 0; bspc config border_width 0; fi";
          "Print" = "flameshot gui";
        };
      };

      systemd.user.targets.bspwm-session = {
        Unit = {
          Description = "Bspwm session";
          BindsTo = [ "graphical-session.target" ];
          Wants = [ "graphical-session-pre.target" ];
          After = [ "graphical-session-pre.target" ];
        };
      };
    };
}
