{
  stdenv,
  qmk,
}:

{
  qmkSrc,
  keyboardSrc,
  keyboardName,
  keymap ? "default",
}:

stdenv.mkDerivation {
  name = "qmk-firmware-${keyboardName}";

  src = qmkSrc;

  nativeBuildInputs = [
    qmk
  ];

  SKIP_GIT = true;
  SKIP_VERSION = true;

  postUnpack = ''
    mkdir -p "$sourceRoot/keyboards/${keyboardName}"
    cp -r ${keyboardSrc}/* "$sourceRoot/keyboards/${keyboardName}/"
  '';

  postPatch = ''
    patchShebangs ./util/uf2conv.py
  '';

  buildPhase = ''
    export QMK_HOME=$(pwd)
    qmk -v compile -kb ${keyboardName} -km ${keymap} -j $NIX_BUILD_CORES
  '';

  installPhase = ''
    mkdir -p "$out"
    shopt -s nullglob
    cp .build/{*.bin,*.elf,*.hex,*.uf2} "$out/"
  '';
}
