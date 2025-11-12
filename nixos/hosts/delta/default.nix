# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  ...
}:

{
  imports = [
    ./users
    ./sops
    ./disks.nix
    ./hardware.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Use a later kernel version for proper Intel BE201 WiFi support.
    kernelPackages = pkgs.linuxPackages_latest;
    kernel = {
      sysctl = {
        "kernel.sysrq" = 1; # https://wiki.archlinux.org/title/Keyboard_shortcuts#Kernel_(SysRq)
      };
      sysfs = {
        module.zswap.parameters = {
          enabled = true;
          zpool = "zsmalloc";
          compressor = "zstd";
          max_pool_percent = "25";
        };
      };
    };
  };

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
    # Garbage collection.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  security = {
    sudo = {
      execWheelOnly = true;
      extraConfig = "Defaults lecture=never";
    };
  };

  # Tell gc to wait for /persist to be mounted to prevent it from
  # thinking that the gc roots are invalid. Otherwise, my devShells get gc'd.
  systemd.services.nix-gc.unitConfig = {
    RequiresMountsFor = "/persist";
  };

  networking.hostName = "delta";

  time.timeZone = "Asia/Singapore";

  i18n.defaultLocale = "en_SG.UTF-8";

  services = {
    btrfs.autoScrub.enable = true;
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
      resolutions = [
        {
          x = 1920;
          y = 1200;
        }
      ];
      displayManager = {
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
    pipewire = {
      enable = true;
      lowLatency = true;
    };
    podman.enable = true;
    qmk.enable = true;
    sddm.enable = true;
    tlp = {
      enable = true;
      diskDevices = [
        "nvme0n1"
      ];
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

  system.stateVersion = "25.05"; # Do not change!
}
