_:

{
  perSystem =
    { pkgs, ... }:
    let
      buildQmk = pkgs.callPackage ./build-qmk.nix { };
      flashQmk = pkgs.callPackage ./flash-qmk.nix { };
    in
    { };
}
