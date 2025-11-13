{ self, ... }:

{
  imports = [ ./pkgs/flake-module.nix ];

  flake = {
    homeManagerModules.planet = self.lib.importModule ./home-manager { };
    nixosModules.planet = self.lib.importModule ./system/nixos { };
  };
}
