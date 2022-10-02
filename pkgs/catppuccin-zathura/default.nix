{
  inputs,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-zathura";
  version = src.lastModifiedDate;

  src = inputs.catppuccin-zathura;

  installPhase = ''
    install -d "$out/share/zathura/themes"
    install src/* "$out/share/zathura/themes"
  '';
}
