{ lib
, stdenvNoCC
, fetchzip
}:
 
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-frappe-dark-cursors";
  version = "unstable-2022-08-23";
 
  src = fetchzip {
    url = "https://github.com/catppuccin/cursors/raw/3d3023606939471c45cff7b643bffc5d5d4ff29c/cursors/Catppuccin-Frappe-Dark-Cursors.zip";
    sha256 = "1njsl4kcqy8d6c9j9bb2id1fiwx9v37mhcc83rm1781pxb2ia8a4";
  };

  installPhase = ''
    install -dm 0755 "$out/share/icons/Catppuccin-Frappe-Dark-Cursors"
    cp -a ./* "$out/share/icons/Catppuccin-Frappe-Dark-Cursors/"
  '';
 
  meta = with lib; {
    description = "Catppuccin cursor theme based on Volantes";
    homepage = "https://github.com/catppuccin/cursors";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
