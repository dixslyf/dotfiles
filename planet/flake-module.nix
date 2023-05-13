{ inputs, flake-parts-lib, withSystem, ... }:

let
  inherit (flake-parts-lib) importApply;
in
{
  imports = [ ./pkgs/flake-module.nix ];

  flake = {
    homeManagerModules.planet = { pkgs, ... }: {
      imports = [
        (
          importApply ./modules/home-manager {
            inherit inputs importApply;
          }
        )
      ];
      _module.args.pers-pkgs = withSystem pkgs.stdenv.hostPlatform.system ({ self', ... }: self'.packages);
    };

    nixosModules.planet = importApply ./modules/nixos {
      inherit inputs importApply;
    };
  };
}
