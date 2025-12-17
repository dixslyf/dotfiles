{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  xz,
  udev,
  ...

}:

let
  version = "0.1.14";
in
rustPlatform.buildRustPackage {
  pname = "vitaly";
  inherit version;

  src = fetchFromGitHub {
    owner = "bskaplou";
    repo = "vitaly";
    rev = "v${version}";
    hash = "sha256-hJHtJG0tn5Xxs6MPIdEGjLya2o4rAESWymS//jc29WE=";
  };

  cargoHash = "sha256-POel9D5ZXxd9bPkHFnTefwl8767tfuYl9hm0w6E/VC8=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    xz
    udev
  ];

  meta = {
    description = "VIA/Vial command line tool ";
    homepage = "https://github.com/bskaplou/vitaly";
  };
}
