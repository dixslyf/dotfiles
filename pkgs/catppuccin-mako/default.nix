{
  inputs,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-mako";
  version = src.lastModifiedDate;

  src = inputs.catppuccin-mako;

  installPhase = ''
    install -d "$out/share/mako/themes/catppuccin"
    install src/* "$out/share/mako/themes/catppuccin"
  '';
}
