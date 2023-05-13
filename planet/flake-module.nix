{ inputs
, flake-parts-lib
, moduleWithSystem
, ...
}:

let
  inherit (flake-parts-lib) importApply;
in
{
  imports = [ ./pkgs/flake-module.nix ];

  flake = {
    homeManagerModules.planet = moduleWithSystem (
      perSystem @ { self' }: importApply ./modules/home-manager {
        inherit inputs importApply;
        inherit (perSystem) self';
      }
    );

    nixosModules.planet = importApply ./modules/nixos {
      inherit inputs importApply;
    };
  };
}
