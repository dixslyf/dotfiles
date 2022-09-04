{ pkgs, inputs, ... }:

{
  imports = [ 
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.hyprland.homeManagerModules.default
  ];

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.persistence."/persist/home/shiba" = {
    directories = [
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Videos"
      ".gnupg"
      ".local/share/Steam"
      ".local/share/lutris"
      ".config/lutris"
      ".local/share/osu"
      ".local/share/qutebrowser"
      ".local/state/wireplumber"
      ".local/share/Euro Truck Simulator 2"
    ];
    allowOther = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
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

  systemd.user.startServices = "sd-switch";
  services = {
    gpg-agent = {
      enable = true;
      enableFishIntegration = true;
      pinentryFlavor = "tty";
    };
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "auto";
    };
    network-manager-applet.enable = true;
    sxhkd = {
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
  };

  home.packages = with pkgs; [
    bottom
    keepassxc
    albert
    neofetch
    xfce.thunar
    fd
    udiskie
    lutris
    vlc
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin 
  ];

  programs = {
    gpg.enable = true;
    git = {
      enable = true;
      userEmail = "dixonseanlow@protonmail.com";
      userName = "PlayerNameHere";
    };
    gitui = {
      enable = true;
      keyConfig =
        ''
          (
            focus_right: Some(( code: Char('l'), modifiers: ( bits: 0,),)),
            focus_left: Some(( code: Char('h'), modifiers: ( bits: 0,),)),
            focus_above: Some(( code: Char('k'), modifiers: ( bits: 0,),)),
            focus_below: Some(( code: Char('j'), modifiers: ( bits: 0,),)),
            open_help: Some(( code: F(1), modifiers: ( bits: 0,),)),
            move_left: Some(( code: Char('h'), modifiers: ( bits: 0,),)),
            move_right: Some(( code: Char('l'), modifiers: ( bits: 0,),)),
            move_up: Some(( code: Char('k'), modifiers: ( bits: 0,),)),
            move_down: Some(( code: Char('j'), modifiers: ( bits: 0,),)),
            popup_up: Some(( code: Char('p'), modifiers: ( bits: 2,),)),
            popup_down: Some(( code: Char('n'), modifiers: ( bits: 2,),)),
            page_up: Some(( code: Char('b'), modifiers: ( bits: 2,),)),
            page_down: Some(( code: Char('f'), modifiers: ( bits: 2,),)),
            home: Some(( code: Char('g'), modifiers: ( bits: 0,),)),
            end: Some(( code: Char('G'), modifiers: ( bits: 1,),)),
            shift_up: Some(( code: Char('K'), modifiers: ( bits: 1,),)),
            shift_down: Some(( code: Char('J'), modifiers: ( bits: 1,),)),
            edit_file: Some(( code: Char('I'), modifiers: ( bits: 1,),)),
            status_reset_item: Some(( code: Char('U'), modifiers: ( bits: 1,),)),
            diff_reset_lines: Some(( code: Char('u'), modifiers: ( bits: 0,),)),
            diff_stage_lines: Some(( code: Char('s'), modifiers: ( bits: 0,),)),
            stashing_save: Some(( code: Char('w'), modifiers: ( bits: 0,),)),
            stashing_toggle_index: Some(( code: Char('m'), modifiers: ( bits: 0,),)),
            stash_open: Some(( code: Char('l'), modifiers: ( bits: 0,),)),
            abort_merge: Some(( code: Char('M'), modifiers: ( bits: 1,),)),
          )
        '';
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
    };
    kitty = {
      enable = true;
      settings = {
        shell = "fish";
      };
    };
    neovim.enable = true;
    firefox = {
      enable = true;
      profiles.default = {
        settings = {
          # Hardware video acceleration
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };
    };
    qutebrowser.enable = true;
    feh.enable = true;
    nnn = {
      enable = true;
    };
  };

  xsession = {
    enable = true;
    windowManager.bspwm = {
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
  };
}
