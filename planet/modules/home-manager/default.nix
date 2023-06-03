{ importModule, ... }:

_:
{
  imports = [
    ./android
    ./autorandr
    (importModule ./bspwm { })
    ./citra
    ./direnv
    ./discord
    ./editorconfig
    ./feh
    ./firefox
    (importModule ./fish { })
    ./flameshot
    ./git
    ./gh
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
    (importModule ./osu-lazer { })
    ./papis
    (importModule ./persistence { })
    ./picom
    ./pointer-cursor
    ./polkit-agent
    (importModule ./polybar { })
    ./qt
    ./qutebrowser
    ./redshift
    (importModule ./rofi { })
    ./ssh
    ./tealdeer
    ./tetrio-desktop
    ./thunar
    ./udiskie
    (importModule ./waybar { })
    (importModule ./wezterm { })
    (importModule ./wired { })
    (importModule ./wlsunset { })
    ./xdg-terminal-exec
    ./yuzu
    (importModule ./zathura { })
  ];
}

