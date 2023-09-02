{ importModule
, ...
}:

_: {
  imports = [
    ./btrfs
    ./earlyoom
    (importModule ./hyprland { })
    ./mullvad-vpn
    ./neovim
    ./network-manager
    (importModule ./nvidia { })
    (importModule ./persistence { })
    (importModule ./pipewire { })
    (importModule ./sddm { })
    (importModule ./sessions { })
    ./steam
    ./tlp
    ./udisks2
    ./upower
    ./virtualisation
    ./xdg
  ];
}
