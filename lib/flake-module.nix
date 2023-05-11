{ self
, inputs
, homeUsers # From home-manager flake-module via `_module.args`
, ...
}:
{
  flake.lib =
    let
      inherit (inputs) nixpkgs;

      # Adapted from https://stackoverflow.com/questions/54504685/nix-function-to-merge-attributes-records-recursively-and-concatenate-arrays
      recursiveMergeAttrs = builtins.zipAttrsWith
        (name: values:
          if builtins.tail values == [ ]
          then builtins.head values
          else if builtins.all builtins.isList values
          then nixpkgs.lib.lists.unique (builtins.concatLists values)
          else if builtins.all builtins.isAttrs values
          then recursiveMergeAttrs values
          else abort "Conflicting unmergeable values for ${name}"
        );
    in
    {
      recursiveMerge = recursiveMergeAttrs;

      mkNixosSystem = extraConfig:
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
    };
}
