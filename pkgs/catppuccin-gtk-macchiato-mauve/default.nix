{
  inputs,
  lib,
  stdenvNoCC,
  unzip,
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-gtk-macchiato-mauve";
  version = builtins.substring 6 6 src.narHash;

  src = inputs.catppuccin-gtk-macchiato-mauve;

  # Work around nix#7083
  nativeBuildInputs = [unzip];
  unpackCmd = ''
    unzip -d "extracted" "$curSrc"
  '';

  installPhase = ''
    install -dm 0755 "$out/share/themes"
    cp -a "Catppuccin-Macchiato-Mauve" "$out/share/themes/"
  '';

  meta = with lib; {
    description = "Catppuccin GTK theme based on the Colloid theme";
    homepage = "https://github.com/catppuccin/gtk";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
