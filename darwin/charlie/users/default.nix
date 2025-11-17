{
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ./corgi
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  system.primaryUser = config.users.users.corgi.name;
}
