{
  config,
  homeUsers,
  ...
}:
{
  users = {
    users = {
      husky = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "video"
          "wheel"
          # For KMonad
          "input"
          "uinput"
        ];
        hashedPasswordFile = config.sops.secrets."user-passwords/husky".path;
      };
    };
  };

  home-manager = {
    users = {
      husky = {
        imports = [
          homeUsers.husky.homeConfiguration
        ];
      };
    };
  };
}
