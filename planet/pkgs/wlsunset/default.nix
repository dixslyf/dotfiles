{
  src,
  stdenv,
  meson,
  pkg-config,
  ninja,
  wayland-scanner,
  scdoc,
  wayland,
  wayland-protocols,
}:
stdenv.mkDerivation {
  pname = "wlsunset";
  version = src.revision;

  inherit src;

  strictDeps = true;
  depsBuildBuild = [
    pkg-config
  ];
  nativeBuildInputs = [
    meson
    pkg-config
    ninja
    wayland-scanner
    scdoc
  ];
  buildInputs = [
    wayland
    wayland-protocols
  ];
}
