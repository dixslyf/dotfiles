{ self
, inputs
, ...
}:
{
  perSystem = { pkgs, ... }: {
    packages = {
      alpha-deploy-spec = self.lib.mkDeploySpec pkgs "alpha";
      bravo-deploy-spec = self.lib.mkDeploySpec pkgs "bravo";
    };
  };

  flake = {
    nixosConfigurations =
      {
        alpha = self.lib.mkNixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.overlays = [
                inputs.neovim-nightly-overlay.overlay
                inputs.hyprland.overlays.default
              ];
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
