{
  src,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-waybar";
  version = src.revision;

  inherit src;

  installPhase = ''
    install -d "$out/share/waybar/themes/catppuccin"
    install themes/* "$out/share/waybar/themes/catppuccin"
  '';
}
