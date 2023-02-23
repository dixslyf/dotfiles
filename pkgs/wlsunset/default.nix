{ sources
, stdenv
, meson
, pkg-config
, ninja
, wayland-scanner
, scdoc
, wayland
, wayland-protocols
,
}:
stdenv.mkDerivation rec {
  pname = "wlsunset";
  version = src.revision;

  src = sources.wlsunset;

  strictDeps = true;
  depsBuildBuild = [
    pkg-config
  ];
  nativeBuildInputs = [ meson pkg-config ninja wayland-scanner scdoc ];
  buildInputs = [ wayland wayland-protocols ];
}
