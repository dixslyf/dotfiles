{ withSystem, ... }:
{
  imports = [ ./pkgs/flake-module.nix ];

  flake = {
    homeManagerModules.planet = { pkgs, ... }: {
      imports = [
        ./modules/home-manager
      ];
      _module.args.pers-pkgs = withSystem pkgs.stdenv.hostPlatform.system ({ self', ... }: self'.packages);
    };

    nixosModules.planet = import ./modules/nixos;
  };
}
