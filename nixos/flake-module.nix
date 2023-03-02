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
    nixosConfigurations =
      let
        inherit (inputs) nixpkgs;
      in
      {
        shiba-asus = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.overlays = nixpkgs.lib.lists.unique ([
                self.overlays.pers-pkgs
                inputs.neovim-nightly-overlay.overlay
              ]
              ++ homeUsers.shiba.overlays);
              nix.registry.nixpkgs.flake = nixpkgs;
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
