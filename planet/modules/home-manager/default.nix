{ importModule, ... }:

_:
{
  imports = [
    ./android
    ./anki
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
    ./glab
    ./gpg
    ./gpg-agent
    (importModule ./gtk { })
    (importModule ./hyprland { })
    ./kdenlive
    (importModule ./kitty { })
    ./logseq
    ./lutris
    (importModule ./mako { })
    ./mpv
    ./mullvad-browser
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
    (importModule ./sioyek { })
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
    ./zotero
    ./zoxide
  ];
}

