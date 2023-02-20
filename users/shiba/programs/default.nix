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
    ./tetrio-desktop
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
    gdb
    exa
    rnote
    android-file-transfer
    pavucontrol
  ];
}
