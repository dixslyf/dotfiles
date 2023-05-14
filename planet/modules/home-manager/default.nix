{ importPlanetModule, ... }:

_:
{
  imports = [
    ./android
    ./autorandr
    (importPlanetModule ./bspwm { })
    (importPlanetModule ./citra { })
    ./direnv
    ./discord
    ./editorconfig
    ./firefox
    (importPlanetModule ./fish { })
    ./flameshot
    ./git
    (importPlanetModule ./gitui { })
    ./gpg
    ./gpg-agent
    (importPlanetModule ./gtk { })
    (importPlanetModule ./hyprland { })
    ./kdenlive
    (importPlanetModule ./kitty { })
    ./lutris
    (importPlanetModule ./mako { })
    ./mullvad-vpn
    (importPlanetModule ./neovim { })
    ./osu-lazer
    (importPlanetModule ./persistence { })
    ./picom
    ./pointer-cursor
    (importPlanetModule ./polybar { })
    ./qt
    ./qutebrowser
    ./redshift
    (importPlanetModule ./rofi { })
    ./ssh
    ./tealdeer
    ./tetrio-desktop
    ./udiskie
    (importPlanetModule ./waybar { })
    ./wezterm
    (importPlanetModule ./wired { })
    (importPlanetModule ./wlsunset { })
    ./yuzu
    (importPlanetModule ./zathura { })
  ];
}

