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
          ./alpha
        ];
      };

      bravo = self.lib.mkNixosSystem {
        modules = [
          ./bravo
        ];
      };

      delta = self.lib.mkNixosSystem {
        modules = [
          inputs.disko.nixosModules.disko
          ./delta
        ];
      };
    };
  };
}
