{ lib
, stdenvNoCC
, fetchzip
}:
 
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-macchiato-dark-cursors";
  version = "unstable-2022-08-23";
 
  src = fetchzip {
    url = "https://github.com/catppuccin/cursors/raw/3d3023606939471c45cff7b643bffc5d5d4ff29c/cursors/Catppuccin-Macchiato-Dark-Cursors.zip";
    sha256 = "1i4n4pmg1f299k9vdgaqpv8l2pmfzbhn5bc0w2ji2gdhxz7fhlyb";
  };

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
