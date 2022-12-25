{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprland
    ./waybar
    ./bspwm
    ./kitty
    ./git
    ./tealdeer
    ./nvim
    ./zathura
    ./firefox
    ./fish
    ./mako
    ./autorandr
    ./rofi
    ./qutebrowser
  ];

  programs = {
    gpg.enable = true;
    ssh.enable = true;
    feh.enable = true;
    nnn.enable = true;
  };

  home.packages = with pkgs; [
    bottom
    keepassxc
    neofetch
    xfce.thunar
    fd
    ripgrep
    udiskie
    lutris
    mpv
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    xdragon
    wofi
    swaybg
    inkscape
    kdenlive
    mediainfo
    gimp
    jq
    grim
    slurp
    swappy
    wl-clipboard
    xclip
    stylua
    editorconfig-checker
    alejandra
    clang-tools
    gdb
    cargo
    rustc
    rustfmt
    rust-analyzer
    clippy
    gcc
    rnix-lsp
    sumneko-lua-language-server
    citra-nightly
    exa
    rnote
  ];
}
