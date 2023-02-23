{
  inputs,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-gitui";
  version = src.lastModifiedDate;

  src = inputs.catppuccin-gitui;

  installPhase = ''
    install -d "$out/share/gitui/"
    install theme/* "$out/share/gitui/"
  '';
}
