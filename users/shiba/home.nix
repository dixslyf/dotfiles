{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./services
    ./programs
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
      ".cache/tealdeer"
    ];
    allowOther = true;
  };

  systemd.user.startServices = "sd-switch";
  services = {
    gpg-agent = {
      enable = true;
      enableFishIntegration = true;
      enableSshSupport = true;
    };
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "auto";
    };
    network-manager-applet.enable = true;
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    bottom
    keepassxc
    albert
    neofetch
    xfce.thunar
    fd
    ripgrep
    udiskie
    lutris
    vlc
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    xdragon
    wofi
    swaybg
    material-design-icons
    iosevka-bin
    (iosevka-bin.override {variant = "sgr-iosevka-term";})
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    inkscape
    kdenlive
    mediainfo
  ];

  programs = {
    gpg.enable = true;
    ssh.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
    };
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

  home.pointerCursor = {
    name = "Catppuccin-Macchiato-Dark-Cursors";
    package = pkgs.pvtpkgs.catppuccin-macchiato-dark-cursors;
    x11.enable = true;
    gtk.enable = true;
    size = 32;
  };

  gtk = {
    enable = true;
    font = {
      package = pkgs.pvtpkgs.mali;
      name = "Mali";
      size = 14;
    };
    theme = {
      package = pkgs.pvtpkgs.catppuccin-gtk-macchiato-mauve;
      name = "Catppuccin-Macchiato-Mauve";
    };
  };
}
