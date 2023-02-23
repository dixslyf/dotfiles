{ sources
, stdenvNoCC
, ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-polybar";
  version = src.revision;

  src = sources.catppuccin-polybar;

  installPhase = ''
    install -d "$out/share/polybar/themes/catppuccin"
    install themes/* "$out/share/polybar/themes/catppuccin"
  '';
}
