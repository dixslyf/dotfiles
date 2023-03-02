{ self
, inputs
, homeUsers  # From home-manager flake-module via `_module.args`
, ...
}:
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
              self.overlays.pers-pkgs
              inputs.nix-gaming.overlays.default
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
        specialArgs = {
          inherit inputs;
          homeUsers = {
            # Pass only specific user(s)
            inherit (homeUsers) shiba;
          };
        };
      };
    };
  };
}
