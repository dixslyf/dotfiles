{ self
, inputs
, withSystem
, ...
}:

let
  homeUsers = {
    shiba = {
      homeConfiguration = {
        imports = [
          self.homeManagerModules.planet
          ./users/shiba
        ];
      };
      overlays = [
        self.overlays.pers-pkgs
        inputs.nix-gaming.overlays.default
        inputs.rust-overlay.overlays.default
        inputs.neovim-nightly-overlay.overlay
        inputs.nil.overlays.default
      ];
    };
    samoyed = {
      homeConfiguration = {
        imports = [
          self.homeManagerModules.planet
          ./users/samoyed
        ];
      };
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
          mkHomeManagerConfiguration = username: extraModule: inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              homeUsers.${username}.homeConfiguration
              extraModule
              {
                home = {
                  inherit username;
                  homeDirectory = "/home/${username}";
                };
                nixpkgs = {
                  inherit (homeUsers.${username}) overlays;
                };
              }
            ];
            extraSpecialArgs = {
              inherit inputs;
            };
          };
        in
        { }
      );
  };
}
