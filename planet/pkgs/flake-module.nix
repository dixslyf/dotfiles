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
    # TODO: figure out lib.makeScope and lib.callPackageWith
    overlays.pers-pkgs = _: prev: {
      pers-pkgs =
        let
          npinsPkgs =
            let
              inherit (prev)
                lib
                callPackage
                ;
              sources = lib.filterAttrs (name: _value: name != "__functor") (import ./npins);
            in
            builtins.mapAttrs (name: value: (callPackage ./${name} { src = value; })) sources;

          iosevkaPkgs =
            let
              inherit (inputs.nixpkgs-iosevka.legacyPackages.${prev.stdenv.system}) callPackage;
            in
            {
              iosevka-custom = callPackage ./iosevka-custom { };
              iosevka-term-custom = callPackage ./iosevka-custom {
                spacing = "term";
              };
            };
        in
        npinsPkgs
        // iosevkaPkgs
        // (
          let
            inherit (prev) callPackage;
          in
          {
            nvidia-offload = callPackage ./nvidia-offload { };
            catppuccin-rofi = callPackage ./catppuccin-rofi { };
            kernelModules = {
              realtek-r8152 = ./realtek-r8152;
            };
            # vimPlugins = prev.lib.recurseIntoAttrs (prev.callPackage ./vim-plugins { });
          }
        );
    };
  };
}
