{ self, ... }:

{
  imports = [ ./pkgs/flake-module.nix ];

  flake = {
    homeManagerModules.planet = self.lib.importModule ./modules/home-manager { };
    nixosModules.planet = self.lib.importModule ./modules/nixos { };
  };
}
