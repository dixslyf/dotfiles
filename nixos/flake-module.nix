{
  self,
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
    };
  };
}
