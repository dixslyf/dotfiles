{ importModule, ... }:

_:
{
  imports = [
    ./android
    ./autorandr
    (importModule ./bspwm { })
    ./citra
    ./default-terminal
    ./direnv
    ./discord
    ./editorconfig
    ./feh
    ./file-roller
    ./firefox
    (importModule ./fish { })
    ./flameshot
    ./fzf
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
    ./mpv
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
    ./xmonad
    ./yuzu
    (importModule ./zathura { })
    ./zoxide
  ];
}

