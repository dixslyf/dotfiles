{ sources
, stdenvNoCC
, ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-fish";
  version = src.revision;

  src = sources.catppuccin-fish;

  installPhase = ''
    install -d "$out/share/fish/themes"
    install themes/* "$out/share/fish/themes"
  '';
}
