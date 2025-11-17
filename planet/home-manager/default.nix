{ importModule, ... }:

_: {
  imports = [
    ./aerospace
    ./android
    ./anki
    (importModule ./autorandr { })
    (importModule ./bspwm { })
    ./cambridge
    ./citra
    ./default-terminal
    ./dev-man-pages
    ./direnv
    ./discord
    ./distrobox
    ./editorconfig
    ./feh
    ./file-roller
    ./firefox
    ./fish
    ./flameshot
    ./fzf
    ./git
    ./gh
    ./gitui
    ./glab
    ./gpg
    ./gpg-agent
    ./gtk
    (importModule ./hyprland { })
    ./kdenlive
    ./kitty
    ./logseq
    ./lutris
    ./mako
    ./mpv
    ./mullvad-browser
    ./mullvad-vpn
    (importModule ./neovim { })
    ./nexusmods-app
    (importModule ./osu-lazer { })
    ./papis
    (importModule ./persistence { })
    ./picom
    ./pointer-cursor
    ./polkit-agent
    ./polybar
    ./qbittorrent
    ./qmk
    ./qt
    ./qutebrowser
    ./redshift
    ./rofi
    ./sioyek
    ./ssh
    ./syncthing
    ./tealdeer
    ./techmino
    ./tetrio-desktop
    ./thunar
    ./tray-target
    ./udiskie
    ./waybar
    ./wezterm
    (importModule ./wired { })
    ./wlsunset
    ./xdg-terminal-exec
    ./yuzu
    ./zathura
    ./zellij
    ./zotero
    ./zoxide
  ];
}
