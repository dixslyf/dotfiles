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
    ./gpg
    ./git
    ./tealdeer
    ./nvim
    ./zathura
    ./firefox
    ./fish
    ./mako
    ./autorandr
    ./rofi
    ./ssh
    ./qutebrowser
    ./yuzu
    ./citra
    ./osu-lazer
  ];

  programs = {
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
    exa
    rnote
  ];
}
