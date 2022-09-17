{
  inputs,
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-macchiato-dark-cursors";
  # No lastModifiedDate since the src is fetched as a zip and not a git repo
  # src.narHash starts with "sha256"
  version = builtins.substring 6 6 src.narHash;

  src = inputs.catppuccin-macchiato-dark-cursors;

  installPhase = ''
    install -dm 0755 "$out/share/icons/Catppuccin-Macchiato-Dark-Cursors"
    cp -a ./* "$out/share/icons/Catppuccin-Macchiato-Dark-Cursors/"
  '';

  meta = with lib; {
    description = "Catppuccin (macchiato flavor) cursor theme based on Volantes";
    homepage = "https://github.com/catppuccin/cursors";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
