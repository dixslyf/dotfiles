{ importModule, ... }:

_:
{
  imports = [
    ./android
    ./autorandr
    (importModule ./bspwm { })
    (importModule ./citra { })
    ./direnv
    ./discord
    ./editorconfig
    ./firefox
    (importModule ./fish { })
    ./flameshot
    ./git
    (importModule ./gitui { })
    ./gpg
    ./gpg-agent
    (importModule ./gtk { })
    (importModule ./hyprland { })
    ./kdenlive
    (importModule ./kitty { })
    ./lutris
    (importModule ./mako { })
    ./mullvad-vpn
    (importModule ./neovim { })
    ./osu-lazer
    (importModule ./persistence { })
    ./picom
    ./pointer-cursor
    (importModule ./polybar { })
    ./qt
    ./qutebrowser
    ./redshift
    (importModule ./rofi { })
    ./ssh
    ./tealdeer
    ./tetrio-desktop
    ./udiskie
    (importModule ./waybar { })
    ./wezterm
    (importModule ./wired { })
    (importModule ./wlsunset { })
    ./yuzu
    (importModule ./zathura { })
  ];
}

