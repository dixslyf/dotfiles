{
  importModule,
  ...
}:

_: {
  imports = [
    ./earlyoom
    ./flatpak
    (importModule ./hyprland { })
    ./mullvad-vpn
    ./neovim
    ./network-manager
    ./nvidia
    (importModule ./persistence { })
    (importModule ./pipewire { })
    ./podman
    ./qmk
    ./sddm
    ./steam
    ./tlp
    ./udisks2
    ./upower
    ./virtualisation
    ./xdg
  ];
}
