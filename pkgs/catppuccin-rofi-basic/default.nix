{
  inputs,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "catppuccin-rofi-basic";
  version = src.lastModifiedDate;

  src = inputs.catppuccin-rofi;

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
