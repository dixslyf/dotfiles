{ catppuccin-papirus-folders-source
, catppuccin-papirus-folders
, papirus-icon-theme
, color ? null
, ...
}:
(papirus-icon-theme.overrideAttrs (_: {
  postUnpack = ''
    cp -r --no-preserve=mode ${catppuccin-papirus-folders-source}/src/* "$sourceRoot"/Papirus
  '';
})).override {
  inherit color;
  papirus-folders = catppuccin-papirus-folders;
}
