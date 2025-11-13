{
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./husky
  ];

  users = {
    mutableUsers = false;
    users.root.hashedPasswordFile = config.sops.secrets."user-passwords/root".path;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];
}
