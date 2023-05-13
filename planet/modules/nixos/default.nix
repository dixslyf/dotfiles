{ inputs, importApply, self' }:
_: {
  imports = [
    ./btrfs
    ./earlyoom
    (importApply ./hyprland { inherit inputs; })
    ./mullvad-vpn
    ./neovim
    ./network-manager
    (importApply ./nvidia { inherit self'; })
    (importApply ./persistence { inherit inputs; })
    (importApply ./pipewire { inherit inputs; })
    ./steam
    ./tlp
    ./udisks2
    ./upower
    ./xdg
  ];
}
