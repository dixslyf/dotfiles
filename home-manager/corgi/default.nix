{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./sops
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "22.05";

    username = "dixslyf";
    homeDirectory = "/Users/dixslyf";
  };

  planet = {
    aerospace.enable = true;
    cambridge.enable = true;
    dev-man-pages.enable = true;
    direnv.enable = true;
    discord.enable = true;
    editorconfig.enable = true;
    fish.enable = true;
    fzf.enable = true;
    gh.enable = true;
    ghostty = {
      enable = true;
      package = pkgs.ghostty-bin;
    };
    git = {
      enable = true;
      profile = "work";
    };
    gitui = {
      enable = true;
      package = pkgs.pers-pkgs.gitui-darwin;
    };
    glab.enable = true;
    gpg.enable = true;
    mpv = {
      enable = true;
      defaultApplication.enable = true;
    };
    neovim = {
      enable = true;
      defaultApplication.enable = true;
    };
    syncthing = {
      enable = true;
      sync = {
        keepass = true;
        logseq = true;
      };
    };
    tealdeer.enable = true;
    wezterm = {
      enable = true;
      defaultTerminal = true;
    };
    zellij.enable = true;
    zoxide.enable = true;
  };

  services = {
    syncthing = {
      settings = {
        gui = {
          user = "corgi";
        };
      };
      passwordFile = config.sops.secrets.syncthing-gui-password.path;
      cert = config.sops.secrets.syncthing-cert.path;
      key = config.sops.secrets.syncthing-key.path;
    };
  };

  programs.fish.plugins = [
    {
      name = "sdkman-for-fish";
      inherit (pkgs.fishPlugins.sdkman-for-fish) src;
    }
  ];

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
    docker-client
    colima
    docker-credential-helpers
    tio
    wget
    xz
    devenv

    # Media
    inkscape

    # Miscellaneous
    keepassxc
    drawio
  ];

  fonts.fontconfig.enable = true;

  targets.darwin = {
    copyApps.enable = true;
    linkApps.enable = false;
  };
}
