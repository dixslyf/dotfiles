{ config, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./shiba
  ];

  sops.secrets."user-passwords/root" = {
    neededForUsers = true;
    sopsFile = ./secrets.yaml;
  };

  users = {
    mutableUsers = false;
    users.root.passwordFile = config.sops.secrets."user-passwords/root".path;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
