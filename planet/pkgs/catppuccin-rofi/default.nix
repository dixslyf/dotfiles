{
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-rofi";
  version = "unstable-2024-20-06";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "rofi";
    rev = "b636a00fd40a7899a8206195464ae8b7f0450a6d";
    hash = "sha256-zA8Zum19pDTgn0KdQ0gD2kqCOXK4OCHBidFpGwrJOqg=";
  };

  installPhase = ''
    CONFIG_RASI="basic/.config/rofi/config.rasi"
    sed -i "/icon-theme/d" "$CONFIG_RASI"
    sed -i "/terminal/d" "$CONFIG_RASI"
    sed -i "/\@theme/d" "$CONFIG_RASI"

    THEMES_DIR="basic/.local/share/rofi/themes"
    for theme in "$THEMES_DIR"/*; do
        [ -e "$theme" ] || continue
        sed -i "/font/d" "$theme"
    done

    PREFIX="$out/share/rofi/themes/catppuccin-basic"
    install -d "$PREFIX"
    install "$CONFIG_RASI" "$PREFIX"
    install "$THEMES_DIR"/* "$PREFIX"
  '';
}
