{ citra-nightly
, fetchFromGitHub
, ...
}:
citra-nightly.overrideAttrs (_:
let version = "1885"; in {
  inherit version;
  src = fetchFromGitHub {
    owner = "citra-emu";
    repo = "citra-nightly";
    rev = "nightly-${version}";
    sha256 = "1rcgcl1ficd3zxpiqs2zih46m7w66qw55zrfaf0zpqn7pkmwcyl3";
    fetchSubmodules = true;
  };
})
