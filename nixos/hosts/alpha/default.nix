{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    ./hardware
    ./users
    inputs.impermanence.nixosModules.impermanence
    inputs.sops-nix.nixosModules.sops
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  # Kernel
  boot = {
    loader.grub.theme = inputs.catppuccin-grub.outPath + "/src/catppuccin-macchiato-grub-theme";
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernel = {
      sysctl = {
        "kernel.sysrq" = 1; # https://wiki.archlinux.org/title/Keyboard_shortcuts#Kernel_(SysRq)
      };
    };
    supportedFilesystems = [ "ntfs" ]; # ntfs-3g driver; required by udisks to mount due to the "windows_names" mount option
  };

  planet.persistence = {
    enable = true;
    persistSystemdDirectories = true;
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
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://playernamehere-nixos.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "playernamehere-nixos.cachix.org-1:oUHiXCIHbB+VbjDIlckfjwaYkJEvpkW3250+FhF5Vi4="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };

  sops = {
    age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yaml;
    secrets."CACHIX_AGENT_TOKEN" = { };
  };

  security = {
    sudo = {
      execWheelOnly = true;
      extraConfig = "Defaults lecture=never";
    };
    rtkit.enable = true;
  };

  services.cachix-agent = {
    enable = true;
    credentialsFile = config.sops.secrets."CACHIX_AGENT_TOKEN".path;
  };

  networking.hostName = "alpha";

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
    videoDrivers = [ "nvidia" ]; # required for nvidia prime
    layout = "us";
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
    displayManager = {
      # disable external monitor in SDDM
      setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off";
      # set the background color of the root window
      sessionCommands = ''
        ${pkgs.hsetroot}/bin/hsetroot -solid "#363a4f"
      '';
      sddm = {
        enable = true;
        theme = "sugar-candy";
      };
    };
    windowManager.bspwm.enable = true;
    desktopManager.runXdgAutostartIfNone = true;
  };

  planet = {
    btrfs = {
      enable = true;
      autoScrubFileSystems = [ "/dev/sda3" "/dev/sdb1" ];
    };
    earlyoom.enable = true;
    hyprland.enable = true;
    mullvad-vpn.enable = true;
    neovim.enable = true;
    networkmanager.enable = true;
    pipewire = {
      enable = true;
      lowLatency = false; # nix-gaming #58
    };
    steam.enable = true;
    tlp = {
      enable = true;
      diskDevices = [ "nvme0n1" "sda" ];
    };
    udisks2.enable = true;
    upower.enable = true;
    xdg.enable = true;
  };

  services = {
    fstrim.enable = true;
    udev.packages = [
      pkgs.android-udev-rules
    ];
    autorandr.enable = true;
    resolved.enable = true;
    blueman.enable = true;
  };

  # Packages
  nixpkgs.config.allowUnfree = true;

  fonts.fonts = [ pkgs.pers-pkgs.mali ];

  environment.systemPackages = with pkgs; [
    pers-pkgs.nvidia-offload
    pciutils
    light
    pamixer
    pers-pkgs.sddm-sugar-candy
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtsvg
  ];

  programs = {
    light.enable = true;
    gamemode.enable = true;
  };
}
