{ importPlanetModule
, ...
}:

_: {
  imports = [
    ./btrfs
    ./earlyoom
    (importPlanetModule ./hyprland { })
    ./mullvad-vpn
    ./neovim
    ./network-manager
    (importPlanetModule ./nvidia { })
    (importPlanetModule ./persistence { })
    (importPlanetModule ./pipewire { })
    (importPlanetModule ./sddm { })
    ./steam
    ./tlp
    ./udisks2
    ./upower
    ./xdg
  ];
}
