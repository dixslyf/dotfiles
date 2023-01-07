{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./autorandr
    ./bspwm
    ./citra
    ./firefox
    ./fish
    ./git
    ./gpg
    ./hyprland
    ./kitty
    ./lutris
    ./mako
    ./nvim
    ./osu-lazer
    ./qutebrowser
    ./rofi
    ./ssh
    ./tealdeer
    ./waybar
    ./yuzu
    ./zathura
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
