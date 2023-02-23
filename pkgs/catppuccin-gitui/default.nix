{ sources
, stdenvNoCC
, ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-gitui";
  version = src.revision;

  src = sources.catppuccin-gitui;

  installPhase = ''
    install -d "$out/share/gitui/"
    install theme/* "$out/share/gitui/"
  '';
}
