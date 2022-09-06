{ config, ... }:

{
  sops.secrets."user-passwords/shiba" = { neededForUsers = true; };

  users = {
    users = {
      shiba = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "video" "wheel" ];
	passwordFile = config.sops.secrets."user-passwords/shiba".path;
      };
    };
  };

  home-manager = {
    users = {
      shiba = import ./home.nix;
    };
  };
}
