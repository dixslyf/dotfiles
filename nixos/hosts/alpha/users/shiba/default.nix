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
      shiba = {
        imports = homeUsers.shiba.homeConfiguration.imports ++ [ ./syncthing ];
      };
    };
  };
}
