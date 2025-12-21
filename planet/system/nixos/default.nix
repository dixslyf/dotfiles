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
