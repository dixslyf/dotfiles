{ self, inputs, ... }:
{
  perSystem =
    { inputs', pkgs, ... }:
    {
      packages = (inputs.flake-utils.lib.flattenTree (self.overlays.pers-pkgs null pkgs).pers-pkgs) // {
        # Re-export to use the version from the Nixpkgs pinned in the flake lock file.
        inherit (inputs'.nixpkgs.legacyPackages) nixpkgs-review;
      };
    };

  flake = {
    overlays.pers-pkgs =
      _: prev:
      let
        sources = import ./npins;
        npinsPackages = builtins.mapAttrs (
          name: value: (prev.callPackage ./${name} { src = value; })
        ) sources;
      in
      {
        # TODO: figure out lib.makeScope and lib.callPackageWith
        pers-pkgs = npinsPackages // {
          nvidia-offload = prev.callPackage ./nvidia-offload { };
          catppuccin-rofi = prev.callPackage ./catppuccin-rofi { };
          iosevka-custom = prev.callPackage ./iosevka-custom { };
          iosevka-term-custom = prev.callPackage ./iosevka-custom { spacing = "term"; };
          kernelModules = {
            realtek-r8152 = ./realtek-r8152;
          };
          # vimPlugins = prev.lib.recurseIntoAttrs (prev.callPackage ./vim-plugins { });
        };
      };
  };
}
