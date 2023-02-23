{
  inputs,
  pkgs,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "sddm-sugar-candy";
  version = src.lastModifiedDate;

  src = inputs.sddm-sugar-candy;

  installPhase = ''
    ${pkgs.imagemagick}/bin/convert -size 1920x1080 canvas:#363a4f Backgrounds/catppuccin.png
    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "Background" "Backgrounds/catppuccin.png"
    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "ScreenWidth" "1920"
    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "ScreenHeight" "1080"
    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "PartialBlur" "false"
    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "HaveFormBackground" "true"
    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "FormPosition" "center"

    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "MainColor" "#cad3f5"
    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "AccentColor" "#b7bdf8"
    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "BackgroundColor" "#24273a"
    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "OverrideLoginButtonTextColor" "#24273a"

    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "InterfaceShadowSize" "4"
    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "InterfaceShadowOpacity" "0.5"

    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "Font" "Mali"

    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "HeaderText" "~welcome~"

    ${pkgs.crudini}/bin/crudini --set --existing theme.conf "General" "ForceHideCompletePassword" "true"

    THEME_DIR="$out/share/sddm/themes/sugar-candy"
    mkdir -p "$THEME_DIR"
    cp -r ./* "$THEME_DIR"
  '';
}
