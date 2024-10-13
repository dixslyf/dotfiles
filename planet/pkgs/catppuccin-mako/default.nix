{
  src,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-mako";
  version = src.revision;

  inherit src;

  installPhase = ''
    install -d "$out/share/mako/themes/catppuccin"
    install src/* "$out/share/mako/themes/catppuccin"
  '';
}
