{ inputs
, flake-parts-lib
, moduleWithSystem
, ...
}:

let
  inherit (flake-parts-lib) importApply;
  importPlanetModule = modulePath: moduleWithSystem (
    { self', inputs' }: importApply modulePath {
      inherit inputs importApply self' inputs';
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
