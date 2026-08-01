{
  importModule,
  ...
}:

_: {
  imports = [
    ./docker
    ./earlyoom
    ./flatpak
    ./mullvad-vpn
    ./neovim
    ./network-manager
    ./nvidia
    (importModule ./persistence { })
    (importModule ./pipewire { })
    ./podman
    ./qmk
    ./secure-boot
    ./sddm
    ./steam
    ./tlp
    ./udisks2
    ./upower
    ./virtualisation
    ./yubikey
    ./xdg
  ];
}
