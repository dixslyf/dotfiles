{
  config,
  homeUsers,
  ...
}:
{
  users = {
    users = {
      husky = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "video"
          "wheel"
          "plugdev" # For QMK
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
