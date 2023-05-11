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
            alpha = self.nixosConfigurations.alpha.config.system.build.toplevel;
          };
        };
    };

  flake = {
    nixosConfigurations =
      let
        inherit (inputs) nixpkgs;
      in
      {
        alpha = self.lib.mkNixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.overlays = nixpkgs.lib.lists.unique ([
                inputs.neovim-nightly-overlay.overlay
                inputs.hyprland.overlays.default
              ]
              ++ homeUsers.shiba.overlays);
            }
            ./hosts/alpha
          ];
        };

        bravo = self.lib.mkNixosSystem {
          modules = [
            { nixpkgs.buildPlatform = "x86_64-linux"; }
            ./hosts/bravo
          ];
        };
      };
  };
}
