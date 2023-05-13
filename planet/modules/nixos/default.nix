{ inputs, importApply }:
_: {
  imports = [
    ./btrfs
    ./earlyoom
    (importApply ./hyprland { inherit inputs; })
    ./mullvad-vpn
    ./neovim
    ./network-manager
    ./nvidia
    (importApply ./persistence { inherit inputs; })
    (importApply ./pipewire { inherit inputs; })
    ./steam
    ./tlp
    ./udisks2
    ./upower
    ./xdg
  ];
}
