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
    in
    {
      inherit recursiveMergeAttrs importModule;

      mkNixosSystem =
        extraConfig:
        let
          config = recursiveMergeAttrs [
            extraConfig
            {
              modules = [
                { imports = [ self.nixosModules.planet ]; }
                { nixpkgs.overlays = [ self.overlays.pers-pkgs ]; }
                { nix.registry.nixpkgs.flake = nixpkgs; }
              ];
              specialArgs = {
                inherit inputs;
                inherit homeUsers;
              };
            }
          ];
        in
        nixpkgs.lib.nixosSystem config;

      mkDarwinSystem =
        extraConfig:
        let
          config = recursiveMergeAttrs [
            extraConfig
            {
              modules = [
                { nixpkgs.overlays = [ self.overlays.pers-pkgs ]; }
                { nix.registry.nixpkgs.flake = nixpkgs; }
              ];
              specialArgs = {
                inherit inputs;
                inherit homeUsers;
              };
            }
          ];
        in
        nix-darwin.lib.darwinSystem config;
    };
}
