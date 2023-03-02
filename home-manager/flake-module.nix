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
      ({ pkgs, ... }:
        let
          mkHomeManagerConfiguration = username: inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = homeUsers.${username}.imports ++ [
              {
                home = {
                  inherit username;
                  homeDirectory = "/home/${username}";
                };
              }
            ];
            extraSpecialArgs = {
              inherit inputs;
            };
          };
        in
        {
          shiba = mkHomeManagerConfiguration "shiba";
        }
      );
  };
}
