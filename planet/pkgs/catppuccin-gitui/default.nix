{
  src,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-gitui";
  version = src.revision;

  inherit src;

  installPhase = ''
    install -d "$out/share/gitui/"
    install themes/* "$out/share/gitui/"
  '';
}
