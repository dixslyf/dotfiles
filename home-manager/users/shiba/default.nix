{ pkgs
, inputs
, ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./sops
  ];

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  systemd.user.startServices = "sd-switch";

  planet = {
    persistence = {
      enable = true;
      persistXdgUserDirectories = true;
      directories = [
        "Sync"
        ".local/share/Steam"
        ".local/state/wireplumber"
        ".factorio"
      ];
    };
    android.enable = true;
    autorandr = {
      enable = true;
      host = "alpha";
    };
    bspwm = {
      enable = true;
      primaryMonitor = "eDP-1";
    };
    citra.enable = true;
    direnv.enable = true;
    discord.enable = true;
    firefox.enable = true;
    fish.enable = true;
    flameshot = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    git.enable = true;
    gitui.enable = true;
    gpg.enable = true;
    gpg-agent.enable = true;
    hyprland = {
      enable = true;
      nvidiaVariables = true;
    };
    kdenlive.enable = true;
    kitty.enable = true;
    lutris.enable = true;
    mako.enable = true;
    mullvad-vpn = {
      enable = true;
      settings = {
        autoConnect = true;
        startMinimized = true;
      };
      systemd.enable = true;
    };
    neovim.enable = true;
    osu-lazer.enable = true;
    picom = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    polybar.enable = true;
    qutebrowser.enable = true;
    redshift = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    rofi.enable = true;
    ssh.enable = true;
    syncthing = {
      enable = true;
      host = "alpha";
    };
    tealdeer.enable = true;
    tetrio-desktop.enable = true;
    udiskie.enable = true;
    waybar = {
      enable = true;
      primaryOutput = "eDP-1";
      externalOutput = "HDMI-A-1";
    };
    wlsunset = {
      enable = true;
      systemd.target = "hyprland-session.target";
    };
    yuzu.enable = true;
    zathura.enable = true;
  };

  services = {
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };

  home.packages = with pkgs; [
    # Fonts
    material-design-icons
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })

    # Some programs e.g. inkscape use adwaita by default
    gnome.adwaita-icon-theme

    # CLI
    jq
    exa
    fd
    ripgrep
    neofetch
    bottom
    udiskie
    gdb

    # Media
    pavucontrol
    feh
    mpv
    gimp
    inkscape

    # X
    xdragon

    # Graphical
    keepassxc
    xfce.thunar
    rnote
    android-file-transfer
  ];

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    name = "Catppuccin-Macchiato-Dark-Cursors";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    x11.enable = true;
    gtk.enable = true;
    size = 32;
  };

  gtk = {
    enable = true;
    font = {
      name = "Mali";
      size = 14;
    };
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "macchiato";
        tweaks = [ "rimless" ];
      };
      name = "Catppuccin-Macchiato-Standard-Mauve-Dark";
    };
    iconTheme = {
      package = pkgs.pers-pkgs.catppuccin-papirus-icon-theme.override {
        color = "cat-macchiato-mauve";
      };
      name = "Papirus-Dark";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        insert_final_newline = true;
        trim_trailing_whitespace = true;
        indent_style = "space";
      };
      "*.nix" = { indent_size = 2; };
      "*.lua" = { indent_size = 3; };
    };
  };
}
