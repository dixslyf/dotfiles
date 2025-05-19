{
  importModule,
  ...
}:

_: {
  imports = [
    ./btrfs
    ./earlyoom
    ./flatpak
    (importModule ./hyprland { })
    ./mullvad-vpn
    ./neovim
    ./network-manager
    (importModule ./nvidia { })
    (importModule ./persistence { })
    (importModule ./pipewire { })
    ./podman
    ./qmk
    (importModule ./sddm { })
    ./steam
    ./tlp
    ./udisks2
    ./upower
    ./virtualisation
    ./xdg
  ];
}
