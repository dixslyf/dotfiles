{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./shiba
  ];

  users = {
    mutableUsers = false;
    users.root.initialPassword = "";  # temporary
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
