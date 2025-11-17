{ self, ... }:

{
  imports = [ ./pkgs/flake-module.nix ];

  flake = {
    homeManagerModules.planet = self.lib.importModule ./home-manager { };
    nixosModules.planet = {
      imports = [
        ./system/common
        (self.lib.importModule ./system/nixos { })
      ];
    };
    darwinModules.planet = {
      imports = [
        ./system/common
      ];
    };
  };
}
