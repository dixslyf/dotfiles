{
  src,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "cambridge-modpack";
  version = src.revision;

  inherit src;

  installPhase = ''
    mkdir -p "$out"
    cp -r * "$out"
  '';
}
