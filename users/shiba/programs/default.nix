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
  ];

  programs = {
    gpg.enable = true;
    ssh.enable = true;
    qutebrowser.enable = true;
    feh.enable = true;
    nnn.enable = true;
  };

  home.packages = with pkgs; [
    bottom
    keepassxc
    albert
    neofetch
    xfce.thunar
    fd
    ripgrep
    udiskie
    lutris
    vlc
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    xdragon
    wofi
    swaybg
    inkscape
    kdenlive
    mediainfo
  ];

}
