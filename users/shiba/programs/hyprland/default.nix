{ inputs, ... }:

{
  imports = [ inputs.hyprland.homeManagerModules.default ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;  # required to use the nixOS module to install hyprland
    xwayland.enable = true;
    extraConfig = ''
      monitor=,preferred,auto,1
      workspace=DP-1,1
      
      input {
          kb_file =
          kb_layout =
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =
      
          follow_mouse = 1
      
          touchpad {
              natural_scroll = true
          }
      
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }
      
      general {
          main_mod = SUPER
      
          gaps_in = 12
          gaps_out = 24

          border_size = 3
          col.active_border = 0x66ee1111
          col.inactive_border = 0x66333333

          cursor_inactive_timeout = 3
      }
      
      decoration {
          rounding = 4
          
          inactive_opacity = 0.5
          
          blur = true
          blur_size = 6
          blur_passes = 3
          blur_new_optimizations = true
          blur_ignore_opacity = true
          
          shadow_range = 8
      }
      
      animations {
          enabled = 1
          animation = windows,1,5,default
          animation = border,1,10,default
          animation = fade,1,10,default
          animation = workspaces,1,5,default
      }
      
      dwindle {
          pseudotile=0 # enable pseudotiling on dwindle
      }
      
      gestures {
          workspace_swipe = true
      }
      
      bind = SUPER,Return,exec,kitty
      bind = SUPERSHIFT,C,killactive,
      bind = SUPERSHIFT,Q,exit,
      bind = SUPER,V,togglefloating,
      bind = SUPER,F,fullscreen,
      bind = SUPER,P,pseudo,
      
      bind = SUPER,h,movefocus,l
      bind = SUPER,l,movefocus,r
      bind = SUPER,k,movefocus,u
      bind = SUPER,j,movefocus,d

      bind = SUPERSHIFT,h,movewindow,l
      bind = SUPERSHIFT,l,movewindow,r
      bind = SUPERSHIFT,k,movewindow,u
      bind = SUPERSHIFT,j,movewindow,d

      bind = SUPER,O,toggleopaque,
      
      bind = SUPER,1,workspace,1
      bind = SUPER,2,workspace,2
      bind = SUPER,3,workspace,3
      bind = SUPER,4,workspace,4
      bind = SUPER,5,workspace,5
      bind = SUPER,6,workspace,6
      bind = SUPER,7,workspace,7
      bind = SUPER,8,workspace,8
      bind = SUPER,9,workspace,9
      bind = SUPER,0,workspace,10
      
      bind = SUPERSHIFT,1,movetoworkspace,1
      bind = SUPERSHIFT,2,movetoworkspace,2
      bind = SUPERSHIFT,3,movetoworkspace,3
      bind = SUPERSHIFT,4,movetoworkspace,4
      bind = SUPERSHIFT,5,movetoworkspace,5
      bind = SUPERSHIFT,6,movetoworkspace,6
      bind = SUPERSHIFT,7,movetoworkspace,7
      bind = SUPERSHIFT,8,movetoworkspace,8
      bind = SUPERSHIFT,9,movetoworkspace,9
      bind = SUPERSHIFT,0,movetoworkspace,10
      
      bind = SUPER,mouse_down,workspace,e+1
      bind = SUPER,mouse_up,workspace,e-1

      bind = SUPER,r,exec,wofi --show drun

      binde = ,XF86AudioRaiseVolume,exec,pamixer -i 1
      binde = SHIFT,XF86AudioRaiseVolume,exec,pamixer -i 2
      binde = ,XF86AudioLowerVolume,exec,pamixer -d 1
      binde = SHIFT,XF86AudioLowerVolume,exec,pamixer -d 2

      binde = ,XF86MonBrightnessUp,exec,light -A 0.2
      binde = SHIFT,XF86MonBrightnessUp,exec,light -A 1
      binde = ,XF86MonBrightnessDown,exec,light -U 0.2
      binde = SHIFT,XF86MonBrightnessDown,exec,light -U 1

      binde = SUPER,XF86AudioRaiseVolume,exec,light -A 0.2
      binde = SUPERSHIFT,XF86AudioRaiseVolume,exec,light -A 1
      binde = SUPER,XF86AudioLowerVolume,exec,light -U 0.2
      binde = SUPERSHIFT,XF86AudioLowerVolume,exec,light -U 1
    '';
  };
}
