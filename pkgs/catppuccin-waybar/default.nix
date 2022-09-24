{
  inputs,
  stdenvNoCC,
  ...
}:

stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-waybar";
  version = src.lastModifiedDate;

  src = inputs.catppuccin-waybar;

  installPhase = ''
    install -d "$out/share/waybar/themes/catppuccin"
    install themes/* "$out/share/waybar/themes/catppuccin"
  '';
}
