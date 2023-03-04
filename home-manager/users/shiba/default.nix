{ pkgs
, inputs
, ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./sops
    ./services
  ];

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

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
    citra.enable = true;
    direnv.enable = true;
    discord.enable = true;
    firefox.enable = true;
    fish.enable = true;
    gpg.enable = true;
    kitty.enable = true;
    lutris.enable = true;
    mako.enable = true;
    osu-lazer.enable = true;
    qutebrowser.enable = true;
    rofi.enable = true;
    tealdeer.enable = true;
    waybar = {
      enable = true;
      primaryOutput = "eDP-1";
      externalOutput = "HDMI-A-1";
    };
    yuzu.enable = true;
    zathura.enable = true;
  };

  home.packages = with pkgs; [
    # Fonts
    material-design-icons
    pers-pkgs.iosevka-custom
    pers-pkgs.iosevka-term-custom
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })

    # Some programs e.g. inkscape use adwaita by default
    gnome.adwaita-icon-theme
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
