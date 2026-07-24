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

  boot = {
    # Use systemd-boot as the boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernel = {
      sysctl = {
        # https://wiki.archlinux.org/title/Keyboard_shortcuts#Kernel_(SysRq)
        "kernel.sysrq" = 1;
      };

      # Configure zswap.
      sysfs = {
        module.zswap.parameters = {
          enabled = true;
          zpool = "zsmalloc";
          compressor = "zstd";
          max_pool_percent = "25";
        };
      };
    };

    binfmt = {
      preferStaticEmulators = true;
      emulatedSystems = [ "aarch64-linux" ];
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

  networking.hostName = "echo";

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
    resolved.enable = true;
    envfs.enable = true;
  };

  planet = {
    earlyoom.enable = true;
    flatpak.enable = true;
    mullvad-vpn.enable = true;
    neovim.enable = true;
    networkmanager.enable = true;
    nix.enable = true;
    pipewire = {
      enable = true;
      lowLatency = true;
    };
    podman.enable = true;
    qmk.enable = true;
    secure-boot.enable = true;
    sddm.enable = true;
    udisks2.enable = true;
    xdg.enable = true;
    yubikey.enable = true;
  };

  # Packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = [ pkgs.pers-pkgs.mali ];

  environment.systemPackages = with pkgs; [
    pciutils
    brightnessctl
    pamixer
  ];

  programs = {
    gamemode.enable = true;
    dconf.enable = true; # Required by home-manager if `gtk.enable = true`
    nix-ld.enable = true;
  };

  system.stateVersion = "26.05"; # Do not change!
}
