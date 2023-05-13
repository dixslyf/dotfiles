{ inputs, importApply }:
_:
{
  imports = [
    ./android
    ./autorandr
    ./bspwm
    ./citra
    ./direnv
    ./discord
    ./firefox
    ./fish
    ./flameshot
    ./git
    ./gitui
    ./gpg
    ./gpg-agent
    (importApply ./hyprland { inherit inputs; })
    ./kdenlive
    ./kitty
    ./lutris
    ./mako
    ./mullvad-vpn
    ./neovim
    ./osu-lazer
    (importApply ./persistence { inherit inputs; })
    ./picom
    ./polybar
    ./qutebrowser
    ./redshift
    ./rofi
    ./ssh
    ./tealdeer
    ./tetrio-desktop
    ./udiskie
    ./waybar
    ./wezterm
    (importApply ./wired { inherit inputs; })
    ./wlsunset
    ./yuzu
    ./zathura
  ];
}

