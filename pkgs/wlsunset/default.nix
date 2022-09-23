{ inputs, lib, stdenv, fetchFromSourcehut
, meson, pkg-config, ninja, wayland-scanner, scdoc
, wayland, wayland-protocols
}:

stdenv.mkDerivation rec {
  pname = "wlsunset";
  version = src.lastModifiedDate;

  src = inputs.wlsunset;

  strictDeps = true;
  depsBuildBuild = [
    pkg-config
  ];
  nativeBuildInputs = [ meson pkg-config ninja wayland-scanner scdoc ];
  buildInputs = [ wayland wayland-protocols ];
}
