{
  self,
  flake-parts-lib,
  moduleWithSystem,
  inputs,
  homeUsers, # From home-manager flake-module via `_module.args`
  ...
}:
{
  flake.lib =
    let
      inherit (inputs)
        nixpkgs
        nix-darwin
        ;

      # Adapted from https://stackoverflow.com/questions/54504685/nix-function-to-merge-attributes-records-recursively-and-concatenate-arrays
      recursiveMergeAttrs = builtins.zipAttrsWith (
        name: values:
        if builtins.tail values == [ ] then
          builtins.head values
        else if builtins.all builtins.isList values then
          nixpkgs.lib.lists.unique (builtins.concatLists values)
        else if builtins.all builtins.isAttrs values then
          recursiveMergeAttrs values
        else
          abort "Conflicting unmergeable values for ${name}"
      );

      importModule =
        modulePath: args:
        moduleWithSystem (
          { self', inputs' }:
          flake-parts-lib.importApply modulePath (
            {
              inherit importModule;
              localFlake = self;
              localFlakeInputs = inputs;
              localFlake' = self';
              localFlakeInputs' = inputs';
            }
            // args
          )
        );

      commonSystemConfig = {
        modules = [
          {
            nixpkgs.overlays = [
              self.overlays.pers-pkgs
              inputs.devenv.overlays.default
            ];
          }
          { nix.registry.nixpkgs.flake = nixpkgs; }
        ];
        specialArgs = {
          inherit inputs;
          inherit homeUsers;
          localFlake = self;
        };
      };

      mkSystemWith =
        mkSystem: extraConfig:
        let
          config = recursiveMergeAttrs [
            commonSystemConfig
            extraConfig
          ];
        in
        mkSystem config;
    in
    {
      inherit
        recursiveMergeAttrs
        importModule
        ;

      mkNixosSystem =
        extraConfig:
        mkSystemWith nixpkgs.lib.nixosSystem (recursiveMergeAttrs [
          {
            modules = [
              { imports = [ self.nixosModules.planet ]; }
            ];
          }
          extraConfig
        ]);

      mkDarwinSystem =
        extraConfig:
        mkSystemWith nix-darwin.lib.darwinSystem (recursiveMergeAttrs [
          {
            modules = [
              { imports = [ self.darwinModules.planet ]; }
            ];
          }
          extraConfig
        ]);
    };
}
