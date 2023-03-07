{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages = inputs.flake-utils.lib.flattenTree (self.overlays.pers-pkgs null pkgs).pers-pkgs;
  };

  flake = {
    overlays.pers-pkgs = inputs.nixpkgs.lib.composeExtensions inputs.hyprland.overlays.default (_: prev:
      let
        sources = import ./npins;
        npinsPackages = builtins.mapAttrs
          (name: value: (prev.callPackage ./${name} { src = value; }))
          sources;
      in
      {
        # TODO: figure out lib.makeScope and lib.callPackageWith
        pers-pkgs = npinsPackages // {
          nvidia-offload = prev.callPackage ./nvidia-offload { };
          catppuccin-papirus-icon-theme = prev.callPackage ./catppuccin-papirus {
            inherit (npinsPackages) catppuccin-papirus-folders;
            catppuccin-papirus-folders-source = sources.catppuccin-papirus-folders;
          };
          iosevka-custom = prev.callPackage ./iosevka-custom { };
          iosevka-term-custom = prev.callPackage ./iosevka-custom { spacing = "term"; };
          # vimPlugins = prev.lib.recurseIntoAttrs (prev.callPackage ./vim-plugins { });
          waybar = prev.callPackage ./waybar { };
        };
      });
  };
}
