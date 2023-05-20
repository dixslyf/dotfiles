{ importModule
, localFlakeInputs'
, ...
}:

{ pkgs, ... }: {
  imports = [
    (importModule ./sops { })
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
    editorconfig.enable = true;
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
    gtk.enable = true;
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
    neovim = {
      enable = true;
      # FIXME: uncomment once fixed upstream
      # Context: https://github.com/nvim-treesitter/nvim-treesitter/issues/4805
      # package = localFlakeInputs'.neovim-nightly-overlay.packages.default;
      nilPackage = localFlakeInputs'.nil.packages.default;
    };
    osu-lazer.enable = true;
    picom = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    pointer-cursor.enable = true;
    polkit-agent.enable = true;
    polybar.enable = true;
    qt.enable = true;
    qutebrowser.enable = true;
    redshift = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    rofi.enable = true;
    ssh.enable = true;
    tealdeer.enable = true;
    tetrio-desktop.enable = true;
    udiskie.enable = true;
    waybar = {
      enable = true;
      primaryOutput = "eDP-1";
      externalOutput = "HDMI-A-1";
    };
    wired = {
      enable = true;
      systemd.target = "bspwm-session.target";
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
}
