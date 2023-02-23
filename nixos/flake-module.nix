{ self, inputs, ... }:
{
  perSystem =
    { pkgs
    , ...
    }: {
      packages.cachix-deploy-spec =
        let
          cachix-deploy-lib = inputs.cachix-deploy.lib pkgs;
        in
        cachix-deploy-lib.spec {
          agents = {
            shiba-asus = self.nixosConfigurations.shiba-asus.config.system.build.toplevel;
          };
        };
    };

  flake = {
    nixosConfigurations = {
      shiba-asus = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            nixpkgs.overlays = [
              inputs.pers-pkgs.overlays.default
              inputs.rust-overlay.overlays.default
              inputs.neovim-nightly-overlay.overlay
              inputs.nil.overlays.default
              (_: final: {
                discord = final.discord.overrideAttrs (_: {
                  src = inputs.discord;
                });
              })
            ];
            nix.registry.nixpkgs.flake = inputs.nixpkgs;
          }
          ./hosts/shiba-asus
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
