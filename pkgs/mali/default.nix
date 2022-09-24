{
  inputs,
  lib,
  stdenvNoCC,
  ...
}:

stdenvNoCC.mkDerivation rec {
  pname = "mali";  
  version = src.lastModifiedDate;

  src = inputs.mali;

  installPhase = ''
    fontdir="$out/share/fonts/truetype"
    install -d "$fontdir"
    install fonts/*.ttf "$fontdir"
  '';

  meta = with lib; {
    description = "Mali is a Thai and Latin family which was inspired by a 6th graders' handwriting. It exudes a carefree and naive appearance.";
    homepage = "https://github.com/cadsondemak/Mali";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
