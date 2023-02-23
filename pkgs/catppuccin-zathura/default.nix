{ src
, stdenvNoCC
, ...
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-zathura";
  version = src.revision;

  inherit src;

  installPhase = ''
    install -d "$out/share/zathura/themes"
    install src/* "$out/share/zathura/themes"
  '';
}
