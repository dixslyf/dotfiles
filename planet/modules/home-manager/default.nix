{ inputs, importApply, self' }:
_:
{
  imports = [
    ./android
    ./autorandr
    (importApply ./bspwm { inherit self'; })
    (importApply ./citra { inherit self'; })
    ./direnv
    ./discord
    ./firefox
    (importApply ./fish { inherit self'; })
    ./flameshot
    ./git
    (importApply ./gitui { inherit self'; })
    ./gpg
    ./gpg-agent
    (importApply ./gtk { inherit self'; })
    (importApply ./hyprland { inherit inputs; })
    ./kdenlive
    (importApply ./kitty { inherit self'; })
    ./lutris
    (importApply ./mako { inherit self'; })
    ./mullvad-vpn
    ./neovim
    ./osu-lazer
    (importApply ./persistence { inherit inputs; })
    ./picom
    (importApply ./polybar { inherit self'; })
    ./qutebrowser
    ./redshift
    (importApply ./rofi { inherit self'; })
    ./ssh
    ./tealdeer
    ./tetrio-desktop
    ./udiskie
    (importApply ./waybar { inherit self'; })
    ./wezterm
    (importApply ./wired { inherit inputs self'; })
    (importApply ./wlsunset { inherit self'; })
    ./yuzu
    (importApply ./zathura { inherit self'; })
  ];
}

