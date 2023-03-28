_:
{
  imports = [ ./pkgs/flake-module.nix ];

  flake = {
    homeManagerModules.planet = import ./modules/home-manager;
    nixosModules.planet = import ./modules/nixos;
  };
}
