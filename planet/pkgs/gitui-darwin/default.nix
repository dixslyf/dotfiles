# Current nixpkgs build for aarch64-darwin is broken (v0.27.0), so we fetch directly from the upstream release.
{
  src,
  stdenvNoCC,
  fetchzip,
  ...
}:

let
  inherit (src) version;
in
stdenvNoCC.mkDerivation {
  pname = "gitui";
  inherit version;

  src = fetchzip {
    url = "https://github.com/gitui-org/gitui/releases/download/v${version}/gitui-mac.tar.gz";
    hash = "sha256-DqLWGyiNEdmuBgLDkFNR9F+eYeY09GqWmLaepFCpSZk=";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -m755 gitui $out/bin/gitui
  '';
}
