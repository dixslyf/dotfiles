{
  self,
  inputs,
  ...
}:
{
  flake = {
    nixosConfigurations = {
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

      delta = self.lib.mkNixosSystem {
        modules = [
          inputs.disko.nixosModules.disko
          ./hosts/delta
        ];
      };
    };
    darwinConfigurations = {
      charlie = self.lib.mkDarwinSystem {
        modules = [
          ./hosts/charlie
        ];
      };
    };
  };
}
