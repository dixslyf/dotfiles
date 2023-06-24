{ pkgs, ... }:

{
  languages.haskell = {
    enable = true;
    package = pkgs.ghc.withPackages (hpkgs: with hpkgs; [
      xmonad
      xmonad-contrib
      X11
    ]);
  };

  pre-commit = {
    hooks = {
      cabal-fmt.enable = true;
      ormolu.enable = true;
    };

    settings.statix.ignore = [ "planet/pkgs/npins/" "planet/pkgs/vim-plugins/npins/" ];
  };
}
