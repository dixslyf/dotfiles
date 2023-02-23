{
  inputs,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-fish";
  version = src.lastModifiedDate;

  src = inputs.catppuccin-fish;

  installPhase = ''
    install -d "$out/share/fish/themes"
    install themes/* "$out/share/fish/themes"
  '';
}
