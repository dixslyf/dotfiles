{ pkgs, ... }:
{
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  planet = {
    cambridge.enable = true;
    dev-man-pages.enable = true;
    direnv.enable = true;
    discord.enable = true;
    editorconfig.enable = true;
    fish.enable = true;
    fzf.enable = true;
    gh.enable = true;
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
    # ssh.enable = true;
    tealdeer.enable = true;
    wezterm = {
      enable = true;
      defaultTerminal = true;
    };
    zellij.enable = true;
    zoxide.enable = true;
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
    docker-client
    colima
    wget
    xz
    # localFlakeInputs'.devenv.packages.default

    # Media
    inkscape

    # Miscellaneous
    keepassxc
    drawio
  ];

  fonts.fontconfig.enable = true;
}
