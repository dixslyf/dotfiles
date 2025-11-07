{
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ./dixslyf
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
}
