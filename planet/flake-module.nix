{ inputs
, flake-parts-lib
, moduleWithSystem
, ...
}:

let
  inherit (flake-parts-lib) importApply;
  importPlanetModule = modulePath: moduleWithSystem (
    { self' }: importApply modulePath {
      inherit inputs importApply self';
    }
  );
in
{
  imports = [ ./pkgs/flake-module.nix ];

  flake = {
    homeManagerModules.planet = importPlanetModule ./modules/home-manager;
    nixosModules.planet = importPlanetModule ./modules/nixos;
  };
}
