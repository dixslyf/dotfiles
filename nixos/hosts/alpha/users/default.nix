{ config
, inputs
, ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./shiba
  ];

  users = {
    mutableUsers = false;
    users.root.passwordFile = config.sops.secrets."user-passwords/root".path;
  };

  home-manager = {
    useUserPackages = true;
  };
}
