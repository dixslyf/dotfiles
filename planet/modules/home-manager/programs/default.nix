{ pkgs
, ...
}: {
  imports = [
    ./android
    ./autorandr
    ./bspwm
    ./citra
    ./direnv
    ./discord
    ./firefox
    ./fish
    ./git
    ./gitui
    ./gpg
    ./hyprland
    ./kitty
    ./lutris
    ./mako
    ./neovim
    ./osu-lazer
    ./qutebrowser
    ./rofi
    ./ssh
    ./tealdeer
    ./tetrio-desktop
    ./waybar
    ./wezterm
    ./yuzu
    ./zathura
  ];

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
    gdb
    exa
    rnote
    android-file-transfer
    pavucontrol
    feh
  ];
}
