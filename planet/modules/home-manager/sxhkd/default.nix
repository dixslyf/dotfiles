{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.sxhkd = {
        enable = mkEnableOption "planet sxhkd";
        systemd.target = mkOption {
          type = types.str;
          default = "bspwm-session.target";
          description = "The systemd target that will automatically start the sxhkd service.";
        };
      };
    };

  config =
    let
      cfg = config.planet.sxhkd;
      inherit (lib) mkIf;
      sxhkdCommand = ''
        /bin/sh -login -c '${config.services.sxhkd.package}/bin/sxhkd ${toString config.services.sxhkd.extraOptions}'
      '';
    in
    mkIf cfg.enable {
      systemd.user.services.sxhkd = {
        Unit = {
          Description = "sxhkd";
          PartOf = [ cfg.systemd.target ];
          After = [ cfg.systemd.target ];
        };

        Service.ExecStart = sxhkdCommand;

        Install = { WantedBy = [ cfg.systemd.target ]; };
      };

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
          "super + {1-9,0} + {_,shift}" = ''num={1-9,10}; if [ $(bspc query -D -d focused --names | cut -c 2) != "$num" ]; then bspc {desktop -f,node -d} focused:^"$num"; fi''; # focus / move window to desktop
          "super + {o,p}" = "bspc desktop -f {prev,next}.local"; # focus the next/prev desktop in the current monitor
          "super + Return" = "wezterm"; # open terminal
          "{XF86MonBrightnessUp,XF86MonBrightnessDown} + {_,shift}" = "light -{A,U} {0.2,1}";
          "super + {XF86AudioRaiseVolume,XF86AudioLowerVolume} + {_,shift}" = "light -{A,U} {0.2,1}";
          "{XF86AudioRaiseVolume,XF86AudioLowerVolume} + {_,shift}" = "pamixer -{i,d} {1,2}";
          "XF86AudioMute" = "pamixer --toggle-mute";
          "super + r" = "rofi -show drun";
          "Print" = "flameshot gui";
        };
      };
    };
}
