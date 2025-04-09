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
  };

  security = {
    sudo = {
      execWheelOnly = true;
      extraConfig = "Defaults lecture=never";
    };
    rtkit.enable = true;
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

  services = {
    cachix-agent = {
      enable = true;
      credentialsFile = config.sops.secrets."CACHIX_AGENT_TOKEN".path;
    };
    logind.powerKey = "ignore";
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "compose:ralt"; # Use right alt as the compose key.
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
    udev.packages = with pkgs; [
      android-udev-rules
    ];
    autorandr.enable = true;
    resolved.enable = true;
    blueman.enable = true;
    envfs.enable = true;
  };

  planet = {
    btrfs = {
      enable = true;
      autoScrubFileSystems = [
        "/dev/sda3"
        "/dev/sdb1"
      ];
    };
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
    podman.enable = true;
    sddm.enable = true;
    tlp = {
      enable = true;
      diskDevices = [
        "nvme0n1"
        "sda"
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
}
