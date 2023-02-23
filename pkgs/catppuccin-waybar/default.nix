{ sources
, stdenvNoCC
, ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-waybar";
  version = src.revision;

  src = sources.catppuccin-waybar;

  installPhase = ''
    install -d "$out/share/waybar/themes/catppuccin"
    install themes/* "$out/share/waybar/themes/catppuccin"
  '';
}
