{ self, ... }: {
  perSystem = { pkgs, ... }: {
    packages = (self.overlays.pers-pkgs null pkgs).pers-pkgs;
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
        pers-pkgs = npinsPackages // {
          nvidia-offload = prev.callPackage ./nvidia-offload { };
          catppuccin-papirus-icon-theme = prev.callPackage ./catppuccin-papirus {
            inherit (npinsPackages) catppuccin-papirus-folders;
            catppuccin-papirus-folders-source = sources.catppuccin-papirus-folders;
          };
          # vimPlugins = prev.lib.recurseIntoAttrs (prev.callPackage ./vim-plugins { inherit sources; });
          waybar = prev.callPackage ./waybar { };
        };
      };
  };
}