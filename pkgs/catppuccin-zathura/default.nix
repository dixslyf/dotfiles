{ sources
, stdenvNoCC
, ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-zathura";
  version = src.revision;

  src = sources.catppuccin-zathura;

  installPhase = ''
    install -d "$out/share/zathura/themes"
    install src/* "$out/share/zathura/themes"
  '';
}
