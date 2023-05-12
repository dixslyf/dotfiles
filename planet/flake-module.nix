{ inputs
, withSystem
, ...
}:
{
  imports = [ ./pkgs/flake-module.nix ];

  flake = {
    homeManagerModules.planet = { pkgs, ... }: {
      imports = [
        ./modules/home-manager
      ];

      _module.args = {
        inherit inputs;
        pers-pkgs = withSystem pkgs.stdenv.hostPlatform.system ({ self', ... }: self'.packages);
      };
    };

    nixosModules.planet = _: {
      imports = [
        ./modules/nixos
      ];

      _module.args = {
        inherit inputs;
      };
    };
  };
}
