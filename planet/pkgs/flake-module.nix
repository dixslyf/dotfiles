{ self, inputs, ... }: {
  perSystem = { pkgs, system, ... }: {
    packages =
      let
        inherit (inputs) nixpkgs;
        p = inputs.flake-utils.lib.flattenTree (self.overlays.pers-pkgs null pkgs).pers-pkgs;
      in
      # Exclude `citra-nightly` on `aarch64-linux` as it is marked as broken on that platform
      if system == "aarch64-linux"
      then
        nixpkgs.lib.filterAttrs
          (name: _: name != "citra-nightly")
          p
      else
        p;
  };

  flake = {
    overlays.pers-pkgs = _: prev:
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
          citra-nightly = prev.callPackage ./citra-nightly { };
          iosevka-custom = prev.callPackage ./iosevka-custom { };
          iosevka-term-custom = prev.callPackage ./iosevka-custom { spacing = "term"; };
          # vimPlugins = prev.lib.recurseIntoAttrs (prev.callPackage ./vim-plugins { });
        };
      };
  };
}
