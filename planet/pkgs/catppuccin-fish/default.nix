{
  src,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-fish";
  version = src.revision;

  inherit src;

  installPhase = ''
    mkdir -p "$out/share/fish"
    cp -r themes "$out/share/fish/themes"
  '';
}
