{
  lib,
  fetchFromGitHub,
  kernel,
  stdenv,
}:

let
  version = "2.19.2";
in
stdenv.mkDerivation {
  pname = "realtek-r8152";
  inherit version;

  src = fetchFromGitHub {
    owner = "wget";
    repo = "realtek-r8152-linux";
    rev = "v${version}";
    sha256 = "sha256-9kJF7y1T0/5yxxsIrQycKY53Ksd8JxMEpVXNjX0WRao=";
  };

  hardeningDisable = [
    "pic"
    "format"
  ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  KERNELDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";
  TARGET_PATH = "kernel/drivers/net/usb";

  inherit (kernel) makeFlags;

  # Avoid using the Makefile directly since it does some shenanigans.
  buildPhase = ''
    runHook preBuild

    make -C "$KERNELDIR" M="$PWD" modules

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    make -C "$KERNELDIR" M="$PWD" INSTALL_MOD_PATH="$out" INSTALL_MOD_DIR="$TARGET_PATH" modules_install

    # Install udev rules.
    mkdir -p $out/etc/udev/rules.d
    cp 50-usb-realtek-net.rules $out/etc/udev/rules.d/

    runHook postInstall
  '';

  meta = {
    description = "A kernel module for Realtek RTL8152/RTL8153 Based USB Ethernet Adapters";
    license = lib.licenses.gpl2Only;
    homepage = "https://github.com/wget/realtek-r8152-linux";
    maintainers = with lib.maintainers; [ dixslyf ];
    platforms = lib.platforms.linux;
  };
}
