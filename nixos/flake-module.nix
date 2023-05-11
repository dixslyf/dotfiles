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
        alpha = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { imports = [ self.nixosModules.planet ]; }
            {
              nixpkgs.overlays = nixpkgs.lib.lists.unique ([
                self.overlays.pers-pkgs
                inputs.neovim-nightly-overlay.overlay
                inputs.hyprland.overlays.default
              ]
              ++ homeUsers.shiba.overlays);
              nix.registry.nixpkgs.flake = nixpkgs;
            }
            ./hosts/alpha
          ];
          specialArgs = {
            inherit inputs;
            homeUsers = {
              # Pass only specific user(s)
              inherit (homeUsers) shiba;
            };
          };
        };
        bravo = nixpkgs.lib.nixosSystem {
          modules = [
            { imports = [ self.nixosModules.planet ]; }
            {
              nixpkgs.overlays = [
                self.overlays.pers-pkgs
              ];
              nix.registry.nixpkgs.flake = nixpkgs;
            }
            { nixpkgs.buildPlatform = "x86_64-linux"; }
            ./hosts/bravo
          ];
          specialArgs = {
            inherit inputs;
            homeUsers = {
              inherit (homeUsers) samoyed;
            };
          };
        };
      };
  };
}
