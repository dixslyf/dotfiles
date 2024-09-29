{
  src,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "doomemacs";
  version = src.revision;

  inherit src;

  installPhase = ''
    mkdir -p "$out"
    cp -a * "$out"
  '';
}
