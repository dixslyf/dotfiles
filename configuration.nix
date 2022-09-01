# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, home-manager, impermanence, nix-gaming, hyprland, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      impermanence.nixosModules.impermanence
      home-manager.nixosModules.home-manager
      hyprland.nixosModules.default
    ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };
      grub = {
        enable = true;
        efiSupport = true;
        enableCryptodisk = true;
        devices = [ "nodev" ];
      }; 
    };
    initrd = {
      secrets = {
        "/keyfiles/boot.bin" = "/boot/keyfiles/boot.bin";
        "/keyfiles/root.bin" = "/boot/keyfiles/root.bin";
        "/keyfiles/swap.bin" = "/boot/keyfiles/swap.bin";
        "/keyfiles/home.bin" = "/boot/keyfiles/home.bin";
      };
      luks.devices = {
        "boot" = {
          keyFile = "/keyfiles/boot.bin";
          allowDiscards = true;
        };
        "root" = {
          keyFile = "/keyfiles/root.bin";
          allowDiscards = true;
        };
        "home" = {
          keyFile = "/keyfiles/home.bin";
        };
        "swap" = {
          device = "/dev/disk/by-uuid/aa90c2fe-6966-44b9-9dec-42d54c2217db";
          keyFile = "/keyfiles/swap.bin";
        };
      };
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernel = {
      sysctl = {
        "kernel.sysrq" = 1;  # https://wiki.archlinux.org/title/Keyboard_shortcuts#Kernel_(SysRq)
      };
    };
    supportedFilesystems = [ "ntfs" ];  # ntfs-3g driver; required by udisks to mount due to the "windows_names" mount option
  };

  fileSystems = {
    "/" = { options = [ "size=2G" "mode=755" "noatime" ]; };
    "/boot" = { neededForBoot = true; };
    "/efi" = { options = [ "noatime" ]; };
    "/nix" = { options = [ "compress=zstd" "noatime" ]; };
    "/persist" = {
      neededForBoot = true;
      options = [ "compress=zstd" "noatime" ];
    };
    "/persist/home" = {
      neededForBoot = true;
      options = [ "compress=zstd" "noatime" ];
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidia = {
      modesetting.enable = true;
      # Set up nvidia prime
      prime = {
        offload.enable = true;
        # Can be found using lspci, either under 3D or VGA
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";
      };
    };
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/systemd/coredump"
      "/var/lib/btrfs"
      "/var/lib/systemd/backlight"  # for systemd-backlight to be able to restore brightness
      "/etc/NetworkManager/system-connections"
      "/etc/mullvad-vpn"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  system = {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "22.05"; # Did you read the comment?

    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://nix-gaming.cachix.org" "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  security = {
    sudo  = {
      execWheelOnly = true;
      extraConfig = "Defaults lecture=never";
    };
    rtkit.enable = true;
  };

  networking = {
    hostName = "shiba-asus";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_SG.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];  # required for nvidia prime
    layout = "us";
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
    displayManager.sddm.enable = true;
    windowManager.bspwm.enable = true;
    desktopManager.runXdgAutostartIfNone = true;
  };

  environment.loginShellInit = ''
    export LIBVA_DRIVER_NAME=nvidia
    export CLUTTER_BACKEND=wayland
    # export XDG_SESSION_TYPE=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export MOZ_ENABLE_WAYLAND=1
    export GBM_BACKEND=nvidia-drm
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export WLR_NO_HARDWARE_CURSORS=1
    export WLR_BACKEND=vulkan
    export QT_QPA_PLATFORM=wayland
    export GDK_BACKEND=wayland
  '';

  services = {
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
    };
    fstrim.enable = true;
    btrfs = {
      autoScrub = {
        enable = true;
        fileSystems = [ "/dev/sda3" "/dev/sdb1" ];
      };
    };
    udisks2 = {
      enable = true;
      settings = {
        "mount_options.conf" = {
          defaults = {
            defaults = "noatime";
          };
        };
      };
    };
    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0 = 80;
        DISK_DEVICES = "sda sdb";
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    resolved.enable = true;
    mullvad-vpn.enable = true;
    psd.enable = true;
  };

  # XDG Autostart
  xdg.autostart.enable = true;

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = let nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload"
    ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '';
  in with pkgs; [
    nvidia-offload
    pciutils
    light
    pamixer
    mullvad-vpn
  ];

  programs = {
    fuse.userAllowOther = true;
    light.enable = true;
    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      defaultEditor = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    gamemode = { enable = true; };
    hyprland = {
      enable = true;
      package = null;  # required for using with the home-manager module
    };
  };

  users = {
    mutableUsers = false;
    users = {
      root.initialPassword = "";  # temporary
      shiba = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "video" "wheel" ];
        initialPassword = "";  # temporary
      };
    };
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users = {
      shiba = { pkgs, ... }: {
        imports = [ 
          impermanence.nixosModules.home-manager.impermanence
	  hyprland.homeManagerModules.default
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
	    ".local/share/osu"
	    ".local/share/qutebrowser"
	    ".local/state/wireplumber"
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
		inactive_opacity = 0.7

		blur = true
                blur_size = 16
                blur_passes = 2
		blur_ignore_opacity = true
                blur_new_optimizations = true
		
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
          nix-gaming.packages.${pkgs.system}.osu-lazer-bin 
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
          fish.enable = true;
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
      };
    };
  };
}
