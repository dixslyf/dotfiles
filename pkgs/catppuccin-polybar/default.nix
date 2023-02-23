{ src
, stdenvNoCC
, ...
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-polybar";
  version = src.revision;

  inherit src;

  installPhase = ''
    install -d "$out/share/polybar/themes/catppuccin"
    install themes/* "$out/share/polybar/themes/catppuccin"
  '';
}
