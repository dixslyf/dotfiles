{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";
    systems.url = "github:nix-systems/default";

    # FIXME: https://github.com/cachix/devenv/issues/528
    nix2container.url = "github:nlewo/nix2container";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
  };

  outputs =
    {
      flake-parts,
      devenv,
      systems,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      imports = [ devenv.flakeModule ];

      perSystem =
        { pkgs, ... }:
        {
          devenv.shells.default = {
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
