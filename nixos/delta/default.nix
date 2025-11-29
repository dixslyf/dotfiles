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
    # Use the systemd-boot as the boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Use a later kernel version for proper Intel BE201 WiFi support.
    kernelPackages = pkgs.linuxPackages_latest;

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
        # Disable external monitor
        setupCommands = ''
          ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off
          ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --off
          ${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --off
          ${pkgs.xorg.xrandr}/bin/xrandr --output DP-3 --off
        '';

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
    nix.enable = true;
    pipewire = {
      enable = true;
      lowLatency = true;
    };
    podman.enable = true;
    qmk.enable = true;
    secure-boot.enable = true;
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
