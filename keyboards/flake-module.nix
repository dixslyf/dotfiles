_:
let
  npins = import ./npins;
  vialQmkSrc = npins.vial-qmk;
in
{
  perSystem =
    { pkgs, ... }:
    let
      buildQmk = pkgs.callPackage ./build-qmk.nix { };
      flashQmk = pkgs.callPackage ./flash-qmk.nix { };

      qmk-beekeeb-3w6hs = buildQmk {
        qmkSrc = vialQmkSrc;
        keyboardSrc = ./beekeeb-3w6hs;
        keyboardName = "beekeeb_3w6hs";
        keymap = "vial";
      };

      flash-qmk-beekeeb-3w6hs = flashQmk {
        qmkSrc = vialQmkSrc;
        keyboardName = "beekeeb_3w6hs";
        firmwareFile = "${qmk-beekeeb-3w6hs}/beekeeb_3w6hs_vial.uf2";
      };
    in
    {
      packages = {
        inherit qmk-beekeeb-3w6hs;
        inherit flash-qmk-beekeeb-3w6hs;
      };

      apps = {
        flash-qmk-beekeeb-3w6hs = {
          type = "app";
          program = flash-qmk-beekeeb-3w6hs;
        };
      };
    };
}
