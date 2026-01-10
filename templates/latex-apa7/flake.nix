{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      flake-parts,
      systems,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            packages =
              let
                tex =
                  with pkgs;
                  texlive.combine {
                    inherit (texlive)
                      scheme-basic
                      latexmk
                      apa7
                      microtype
                      newtx
                      newtxtt
                      nowidow
                      multirow
                      xurl
                      biblatex
                      biblatex-apa
                      biber
                      booktabs
                      caption
                      threeparttable
                      float
                      endfloat
                      xkeyval
                      etoolbox
                      xstring
                      fontaxes
                      scalerel
                      pgf
                      latexindent
                      ;
                  };
              in
              [ tex ];
          };
        };
    };
}
