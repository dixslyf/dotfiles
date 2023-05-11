{ config
, homeUsers
, ...
}: {
  users = {
    users = {
      samoyed = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        passwordFile = config.sops.secrets."user-passwords/samoyed".path;
      };
    };
  };

  home-manager = {
    users = {
      samoyed = homeUsers.samoyed.homeConfiguration;
    };
  };
}
