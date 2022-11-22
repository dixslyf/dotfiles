{
  inputs,
  stdenv,
  getent,
  ...
}:
stdenv.mkDerivation rec {
  pname = "catppuccin-papirus-folders";
  version = src.lastModifiedDate;

  src = inputs.catppuccin-papirus-folders;

  buildInputs = [getent];

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
