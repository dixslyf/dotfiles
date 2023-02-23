{ src
, stdenv
, getent
, ...
}:
stdenv.mkDerivation {
  pname = "catppuccin-papirus-folders";
  version = src.revision;

  inherit src;

  buildInputs = [ getent ];

  patchPhase = ''
    substituteInPlace ./papirus-folders --replace "getent" "${getent}/bin/getent"
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"/bin
    install -m 755 papirus-folders "$out"/bin
    runHook postInstall
  '';
}
