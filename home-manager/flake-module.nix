{ inputs
, withSystem
, ...
}:

let
  homeUsers = {
    shiba = {
      imports = [ ./users/shiba ];
    };
  };
in
{
  imports = [
    # Make `homeUsers` available to other flake modules
    # In particular, make it available to the NixOS configuration
    {
      _module.args = {
        inherit homeUsers;
      };
    }
  ];

  flake = {
    homeConfigurations = withSystem "x86_64-linux"
      ({ pkgs, ... }: {
        shiba = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = homeUsers.shiba.imports;
        };
      });
  };
}
