{
  pkgs,
  ...
}:

{
  home.stateVersion = "25.05";
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
      useBindMounts = true;
      persistXdgUserDirectories = true;
      directories = [
        ".local/state/wireplumber"
        ".local/share/flatpak"
        ".var" # Used by `flatpak`
      ];
    };
    autorandr = {
      enable = true;
      host = "delta";
    };
    bspwm = {
      enable = true;
      primaryMonitor = "eDP-1";
    };
    cambridge.enable = true;
    dev-man-pages.enable = true;
    direnv.enable = true;
    discord.enable = true;
    distrobox.enable = true;
    editorconfig.enable = true;
    feh = {
      enable = true;
      defaultApplication.enable = true;
    };
    file-roller = {
      enable = true;
      defaultApplication.enable = true;
    };
    firefox = {
      enable = true;
      defaultApplication.enable = true;
    };
    fish.enable = true;
    flameshot = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    fzf.enable = true;
    gh.enable = true;
    git = {
      enable = true;
      profile = "personal";
    };
    gitui.enable = true;
    glab.enable = true;
    gpg.enable = true;
    gpg-agent.enable = true;
    gtk.enable = true;
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
      defaultApplication.enable = true;
    };
    picom = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    pointer-cursor.enable = true;
    polkit-agent.enable = true;
    polybar.enable = true;
    qmk.enable = true;
    qt.enable = true;
    redshift = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    rofi.enable = true;
    sioyek = {
      enable = true;
      defaultApplication.enable = true;
    };
    ssh.enable = true;
    tealdeer.enable = true;
    techmino.enable = true;
    tetrio-desktop.enable = true;
    thunar = {
      enable = true;
      defaultApplication.enable = true;
    };
    udiskie.enable = true;
    wezterm = {
      enable = true;
      defaultTerminal = true;
    };
    wired = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    zellij.enable = true;
    zoxide.enable = true;
  };

  services = {
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };

  home.packages = with pkgs; [
    # Fonts
    material-design-icons
    nerd-fonts.symbols-only

    # Some programs e.g. inkscape use adwaita by default
    adwaita-icon-theme

    # CLI
    eza
    fd
    ripgrep
    bottom
    ouch
    yazi
    devenv

    # Media
    pavucontrol
    gimp
    inkscape

    # X
    dragon-drop

    # Miscellaneous
    keepassxc
    android-file-transfer
    drawio
    libreoffice
  ];

  fonts.fontconfig.enable = true;
}
