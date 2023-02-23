{ src
, stdenvNoCC
, ...
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-fish";
  version = src.revision;

  inherit src;

  installPhase = ''
    install -d "$out/share/fish/themes"
    install themes/* "$out/share/fish/themes"
  '';
}
