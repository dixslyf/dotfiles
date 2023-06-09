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

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    mimeApps.enable = true;
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
    feh = {
      enable = true;
      defaultApplication.enable = true;
    };
    file-roller = {
      enable = true;
      defaultApplication.enable = true;
    };
    firefox.enable = true;
    fish.enable = true;
    flameshot = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    fzf.enable = true;
    gh.enable = true;
    git.enable = true;
    gitui.enable = true;
    gpg.enable = true;
    gpg-agent.enable = true;
    gtk.enable = true;
    hyprland = {
      enable = true;
      nvidiaVariables = true;
    };
    kdenlive = {
      enable = true;
      defaultApplication.enable = true;
    };
    lutris = {
      enable = true;
      defaultApplication.enable = true;
    };
    mako.enable = true;
    mpv = {
      enable = true;
      defaultApplication.enable = true;
    };
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
      defaultApplication.enable = true;
    };
    osu-lazer = {
      enable = true;
      defaultApplication.enable = true;
    };
    papis.enable = true;
    picom = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    pointer-cursor.enable = true;
    polkit-agent.enable = true;
    polybar.enable = true;
    qt.enable = true;
    qutebrowser = {
      enable = true;
      defaultApplication.enable = true;
    };
    redshift = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    rofi.enable = true;
    ssh.enable = true;
    tealdeer.enable = true;
    tetrio-desktop.enable = true;
    thunar = {
      enable = true;
      defaultApplication.enable = true;
    };
    udiskie.enable = true;
    waybar = {
      enable = true;
      primaryOutput = "eDP-1";
      externalOutput = "HDMI-A-1";
    };
    wezterm = {
      enable = true;
      defaultTerminal = true;
    };
    wired = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    wlsunset = {
      enable = true;
      systemd.target = "hyprland-session.target";
    };
    xmonad.enable = true;
    yuzu.enable = true;
    zathura = {
      enable = true;
      defaultApplication.enable = true;
    };
    zoxide.enable = true;
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
    gimp
    inkscape

    # X
    xdragon

    # Graphical
    keepassxc
    rnote
    android-file-transfer
    drawio
    pencil
  ];

  fonts.fontconfig.enable = true;
}
