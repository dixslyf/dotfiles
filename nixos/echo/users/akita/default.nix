{
  config,
  homeUsers,
  ...
}:
{
  users = {
    users = {
      akita = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "video"
          "wheel"
          "podman"
          "plugdev" # For QMK
          # For KMonad
          "input"
          "uinput"
        ];
        hashedPasswordFile = config.sops.secrets."user-passwords/akita".path;
      };
    };
  };

  home-manager = {
    users = {
      akita = {
        imports = [
          homeUsers.akita.homeConfiguration
        ];
      };
    };
  };
}
