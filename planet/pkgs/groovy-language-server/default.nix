{
  lib,
  stdenv,
  fetchFromGitHub,
  gradle_9,
  makeWrapper,
  jre_minimal,
  jre_headless,
}:

let
  gradle = gradle_9;
  jre = jre_minimal.override {
    # Analysed with jdeps.
    modules = [
      "java.base"
      "java.compiler"
      "java.desktop"
      "java.logging"
      "java.management"
      "java.prefs"
      "java.sql"
      "java.xml"
    ];
    jdk = jre_headless;
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "groovy-language-server";
  version = "unstable-2025-10-10";

  src = fetchFromGitHub {
    owner = "GroovyLanguageServer";
    repo = "groovy-language-server";
    rev = "0466842f2b9e7d2c4620e81e3acf85e56c71097f";
    hash = "sha256-2KRMrJGcx52uBQGyZ8cRW5y9ZUwxMoe1eF90oN3Yppw=";
  };

  nativeBuildInputs = [
    gradle
    makeWrapper
  ];

  mitmCache = gradle.fetchDeps {
    pkg = finalAttrs.finalPackage;
    data = ./deps.json;
  };

  # Required for using mitm-cache on Darwin.
  __darwinAllowLocalNetworking = true;

  gradleFlags = [ "-Dfile.encoding=utf-8" ];

  gradleBuildTask = "shadowJar";

  doCheck = true;

  installPhase = ''
    mkdir -p $out/{bin,share/groovy-language-server}
    cp "build/libs/source-all.jar" "$out/share/groovy-language-server/groovy-language-server-all.jar"

    makeWrapper ${lib.getExe jre} $out/bin/groovy-language-server \
      --add-flags "-jar $out/share/groovy-language-server/groovy-language-server-all.jar"
  '';

  meta = {
    description = "A language server for Groovy — designed for Moonshine IDE, but may be useful in other environments";
    homepage = "https://github.com/GroovyLanguageServer/groovy-language-server";
    sourceProvenance = with lib.sourceTypes; [
      fromSource
      binaryBytecode # mitm-cache
    ];
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [
      dixslyf
    ];
    platforms = lib.platforms.unix;
    mainProgram = "groovy-language-server";
  };
})
