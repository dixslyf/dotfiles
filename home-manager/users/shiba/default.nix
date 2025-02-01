{
  importModule,
  localFlakeInputs',
  ...
}:

{ pkgs, ... }:
{
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
      useBindMounts = true;
      persistXdgUserDirectories = true;
      directories = [
        "Sync"
        ".local/state/wireplumber"
        ".factorio"
        ".local/share/flatpak"
        ".var" # Used by `flatpak`
      ];
    };
    android.enable = true;
    anki.enable = true;
    autorandr = {
      enable = true;
      host = "alpha";
    };
    bspwm = {
      enable = true;
      primaryMonitor = "eDP-1";
    };
    citra.enable = false; # FIXME: Wait for the dust to settle.
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
    git.enable = true;
    gitui.enable = true;
    glab.enable = true;
    gpg.enable = true;
    gpg-agent.enable = true;
    gtk.enable = true;
    kdenlive = {
      enable = true;
      defaultApplication.enable = true;
    };
    lutris = {
      enable = true;
      defaultApplication.enable = true;
    };
    mako.enable = false;
    mpv = {
      enable = true;
      defaultApplication.enable = true;
    };
    mullvad-browser.enable = true;
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
    papis.enable = true;
    picom = {
      enable = true;
      systemd.target = "bspwm-session.target";
    };
    pointer-cursor.enable = true;
    polkit-agent.enable = true;
    polybar.enable = true;
    qbittorrent.enable = true;
    qt.enable = true;
    qutebrowser.enable = true;
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
    tetrio-desktop.enable = true;
    thunar = {
      enable = true;
      defaultApplication.enable = true;
    };
    udiskie.enable = true;
    waybar = {
      enable = false;
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
      enable = false;
      systemd.target = "hyprland-session.target";
    };
    yuzu.enable = false; # FIXME: Wait for the dust to settle.
    zellij.enable = true;
    zotero.enable = true;
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
    localFlakeInputs'.devenv.packages.default

    # Media
    pavucontrol
    gimp
    inkscape

    # X
    xdragon

    # Miscellaneous
    keepassxc
    android-file-transfer
    drawio
    libreoffice
  ];

  fonts.fontconfig.enable = true;

  programs.eww = {
    enable = true;
    systemd.enable = true;
    configDir = ./eww-config;
    yuckConfig = ''
      (defwindow example
        :monitor 0
        :geometry (geometry :x "0%"
                             :y "20px"
                             :width "90%"
                             :height "30px"
                             :anchor "top center")
        :stacking "fg"
        :reserve (struts :distance "40px" :side "top")
        :windowtype "dock"
        :wm-ignore false
      "example content")
    '';
  };
}
