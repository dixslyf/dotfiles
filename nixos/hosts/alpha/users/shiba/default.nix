{ config
, homeUsers
, ...
}: {
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
      shiba = homeUsers.shiba.homeConfiguration;
    };
  };
}
