{
  config,
  homeUsers,
  ...
}:
{
  users = {
    users = {
      shiba = {
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
        hashedPasswordFile = config.sops.secrets."user-passwords/shiba".path;
      };
    };
  };

  home-manager = {
    users = {
      shiba = {
        imports = [
          homeUsers.shiba.homeConfiguration
        ];
      };
    };
  };
}
