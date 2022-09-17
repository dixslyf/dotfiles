{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware
    ../../users
    inputs.impermanence.nixosModules.impermanence
    inputs.sops-nix.nixosModules.sops
    inputs.hyprland.nixosModules.default
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  # Kernel
  boot = {
    loader.grub.theme = inputs.catppuccin-grub.outPath + "/src/catppuccin-macchiato-grub-theme";
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernel = {
      sysctl = {
        "kernel.sysrq" = 1;  # https://wiki.archlinux.org/title/Keyboard_shortcuts#Kernel_(SysRq)
      };
    };
    supportedFilesystems = [ "ntfs" ];  # ntfs-3g driver; required by udisks to mount due to the "windows_names" mount option
  };

  # Opt-in persisted root directories
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
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
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
      substituters = [
        "https://nix-gaming.cachix.org"
	"https://hyprland.cachix.org"
	"https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
	"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
	"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  sops = { age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ]; };

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
      lowLatency.enable = true;
    };
    openssh = {
      enable = true;
      hostKeys = [
        { 
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
	}
      ];
    };
    resolved.enable = true;
    mullvad-vpn.enable = true;
    psd.enable = true;
    upower = {
      enable = true;
      percentageLow = 30;
      percentageCritical = 15;
      percentageAction = 10;
    };
  };

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      # xdg-desktop-portal-wlr should already be enabled by hyprland
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

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
    sops
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
      recommendedEnvironment = false;  # variables are added below to avoid causing issues in x
      package = (inputs.hyprland.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.makeWrapper ];
	postInstall = oldAttrs.postInstall or ''
          wrapProgram $out/bin/Hyprland \
            --set LIBVA_DRIVER_NAME nvidia \
            --set CLUTTER_BACKEND wayland \
            --set XDG_SESSION_TYPE wayland \
            --set QT_WAYLAND_DISABLE_WINDOWDECORATION 1 \
            --set MOZ_ENABLE_WAYLAND 1 \
            --set GBM_BACKEND nvidia-drm \
            --set __GLX_VENDOR_LIBRARY_NAME nvidia \
            --set WLR_NO_HARDWARE_CURSORS 1 \
            --set WLR_BACKEND vulkan \
            --set QT_QPA_PLATFORM wayland \
            --set GDK_BACKEND wayland \
            --set _JAVA_AWT_WM_NONREPARENTING 1 \
            --set NIXOS_OZONE_WL 1
	'';
      })).override { nvidiaPatches = true; };
    };
  };
}
