{
  self,
  ...
}:
{
  flake = {
    darwinConfigurations = {
      charlie = self.lib.mkDarwinSystem {
        modules = [
          ./charlie
        ];
      };
    };
  };
}
