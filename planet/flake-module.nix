{ self
, inputs
, flake-parts-lib
, moduleWithSystem
, ...
}:

let
  importPlanetModule = modulePath: args: moduleWithSystem (
    { self', inputs' }:
    flake-parts-lib.importApply modulePath ({
      inherit importPlanetModule;
      localFlake = self;
      localFlakeInputs = inputs;
      localFlake' = self';
      localFlakeInputs' = inputs';
    } // args)
  );
in
{
  imports = [ ./pkgs/flake-module.nix ];

  flake = {
    homeManagerModules.planet = importPlanetModule ./modules/home-manager { };
    nixosModules.planet = importPlanetModule ./modules/nixos { };
  };
}
