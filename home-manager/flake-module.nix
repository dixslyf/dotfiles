{
  self,
  inputs,
  ...
}:

let
  homeUsers = {
    shiba = {
      homeConfiguration = {
        imports = [
          self.homeManagerModules.planet
          inputs.sops-nix.homeManagerModules.sops
          ./shiba
        ];
      };
    };
    samoyed = {
      homeConfiguration = {
        imports = [
          self.homeManagerModules.planet
          ./samoyed
        ];
      };
    };
    corgi = {
      homeConfiguration = {
        imports = [
          self.homeManagerModules.planet
          inputs.sops-nix.homeManagerModules.sops
          ./corgi
        ];
      };
    };
    husky = {
      homeConfiguration = {
        imports = [
          self.homeManagerModules.planet
          inputs.sops-nix.homeManagerModules.sops
          ./husky
        ];
      };
    };
  };
in
{
  # Make `homeUsers` available to other flake modules
  # In particular, make it available to the NixOS configuration
  _module.args = {
    inherit homeUsers;
  };
}
