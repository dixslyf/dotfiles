{ self
, withSystem
, ...
}:
{
  flake = {
    nixosConfigurations =
      {
        alpha = self.lib.mkNixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/alpha
          ];
        };

        bravo = self.lib.mkNixosSystem {
          modules = [
            ./hosts/bravo
          ];
        };
      };

    ci = withSystem "x86_64-linux" ({ pkgs, ... }: {
      alpha-deploy-spec = self.lib.mkDeploySpec pkgs "alpha";
      bravo-deploy-spec = self.lib.mkDeploySpec pkgs "bravo";
    });
  };
}
