{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware
    ./users
    ./sops
    ./kmonad
  ];

  # Kernel
  boot = {
    loader.grub.theme = inputs.catppuccin-grub.outPath + "/src/catppuccin-macchiato-grub-theme";
    kernel = {
      sysctl = {
        "kernel.sysrq" = 1; # https://wiki.archlinux.org/title/Keyboard_shortcuts#Kernel_(SysRq)
      };
    };
    swraid.enable = false; # https://github.com/NixOS/nixpkgs/issues/254807
  };

  planet.persistence = {
    enable = true;
    persistSystemdDirectories = true;
    persistMachines = true;
    persistSystemdBacklight = true;
    persistLogs = true;
    persistSsh = true;
    persistMachineId = true;
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

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Tell gc to wait for /persist/home to be mounted to prevent it from
  # thinking that the gc roots are invalid. Otherwise, my devShells get gc'd.
  systemd.services.nix-gc.unitConfig = {
    RequiresMountsFor = "/persist/home";
  };

  # Other nix settings
  nix = {
    settings = {
      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://dixslyf.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "dixslyf.cachix.org-1:6x8b4tr/2LBObGAlAGS1fbW3B3nK1FvL0CH9uRxjmI4="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };

  security = {
    sudo = {
      execWheelOnly = true;
      extraConfig = "Defaults lecture=never";
    };
  };

  networking.hostName = "alpha";

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_SG.UTF-8";
  console = {
    useXkbConfig = true; # use xkbOptions in tty.
  };

  services = {
    btrfs.autoScrub.enable = true;
    cachix-agent = {
      enable = false;
      credentialsFile = config.sops.secrets."CACHIX_AGENT_TOKEN".path;
    };
    logind = {
      settings = {
        Login.HandlePowerKey = "ignore";
      };
    };
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
      };
      displayManager = {
        # Disable external monitor
        setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off";

        # Set the background color of the root window
        sessionCommands = ''
          ${pkgs.hsetroot}/bin/hsetroot -solid "#363a4f"
        '';
      };
      windowManager.bspwm.enable = true;
      excludePackages = with pkgs; [ xterm ];
    };
    displayManager.defaultSession = "none+bspwm";
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
    fstrim.enable = true;
    autorandr.enable = true;
    resolved.enable = true;
    blueman.enable = true;
    envfs.enable = true;
  };

  planet = {
    earlyoom.enable = true;
    flatpak.enable = true;
    mullvad-vpn.enable = true;
    neovim.enable = true;
    networkmanager.enable = true;
    nvidia.enable = true;
    pipewire = {
      enable = true;
      lowLatency = true;
    };
    podman = {
      enable = true;
      nvidia-container-toolkit = true;
    };
    qmk.enable = true;
    sddm.enable = true;
    tlp = {
      enable = true;
      diskDevices = [
        "nvme0n1"
        "sda"
      ];
      extraSettings = {
        # For getting the Wavlink 5gbps adapter to work.
        # See:
        # - https://askubuntu.com/questions/1044127/usb-ethernet-adapter-realtek-r8153-keeps-disconnecting
        # - https://forum.manjaro.org/t/no-carrier-network-link-problem-with-usb-2-5-gbit-lan-adapter-realtek-rtl8156b-on-x86-64/97195
        # - https://community.frame.work/t/solved-getting-the-rtl8156-2-5gb-adapter-on-ubuntu-22-04-solution-blacklist-tlp-from-device/23857/4
        # ID was retrieved with `lsusb`.
        USB_DENYLIST = "0bda:8157";
      };
    };
    udisks2.enable = true;
    upower.enable = true;
    xdg.enable = true;
  };

  # Packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = [ pkgs.pers-pkgs.mali ];

  environment.systemPackages = with pkgs; [
    pciutils
    light
    pamixer
  ];

  programs = {
    light.enable = true;
    gamemode.enable = true;
    dconf.enable = true; # Required by home-manager if `gtk.enable = true`
    nix-ld.enable = true;
  };
}
