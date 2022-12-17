{
  inputs,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-polybar";
  version = src.lastModifiedDate;

  src = inputs.catppuccin-polybar;

  installPhase = ''
    install -d "$out/share/polybar/themes/catppuccin"
    install themes/* "$out/share/polybar/themes/catppuccin"
  '';
}
