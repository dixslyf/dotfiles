{ pkgs, ... }: {
  imports = [ ./module.nix ];
  pvt.services.mullvad-vpn = {
    enable = true;
    settings = {
      autoConnect = true;
      startMinimized = true;
      changelogDisplayedForVersion = pkgs.mullvad-vpn.version;
    };
  };
}
