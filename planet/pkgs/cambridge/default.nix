{
  src,
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  makeDesktopItem,
  love,
  zip, # Needed by package.sh
}:

let
  pname = "cambridge";
  description = "The next open source block stacking game";

  desktopItem = makeDesktopItem {
    name = pname;
    exec = "cambridge";
    icon = fetchurl {
      name = "cambridge_icon.png";
      url = "https://raw.githubusercontent.com/cambridge-stacker/cambridge/b23869725af74ab0b08deb2578cd905bc6cd747a/res/img/cambridge_icon.png";
      hash = "sha256-zoRcm5IH4vvgV32CPfODkZngymTw1RqYBjx6mJvyIAc=";
    };
    comment = description;
    desktopName = "Cambridge";
    categories = [ "Game" ];
  };
in

stdenv.mkDerivation {
  inherit
    pname
    src
    ;

  inherit (src) version;

  nativeBuildInputs = [
    makeWrapper
    zip
  ];

  postPatch = ''
    patchShebangs .
  '';

  buildPhase = ''
    runHook preBuild
    ./package.sh
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    CAMBRIDGE_DIR="$out/share/games/lovegames/cambridge"
    mkdir -p "$CAMBRIDGE_DIR"
    mkdir -p "$CAMBRIDGE_DIR/libs"
    cp "./cambridge.love" "$CAMBRIDGE_DIR"
    cp "./libs/discord-rpc.so" "$CAMBRIDGE_DIR/libs"

    mkdir -p "$out/bin"
    makeWrapper ${love}/bin/love $out/bin/cambridge \
      --add-flags "$CAMBRIDGE_DIR/cambridge.love"

    mkdir -p $out/share/applications
    ln -s ${desktopItem}/share/applications/* $out/share/applications/

    runHook postInstall
  '';

  meta = with lib; {
    inherit description;
    downloadPage = "https://github.com/cambridge-stacker/cambridge/releases";
    homepage = "https://github.com/cambridge-stacker/cambridge";
    license = licenses.mit;
    mainProgram = "cambridge";
    maintainers = with maintainers; [ dixslyf ];
  };
}
