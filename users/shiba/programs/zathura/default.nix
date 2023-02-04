{pkgs, ...}: {
  programs.zathura = {
    enable = true;
    options = {
      font = "Iosevka Regular 16";
      recolor = "true";
      selection-clipboard = "clipboard";
    };
    extraConfig = ''
      include ${pkgs.pers-pkgs.catppuccin-zathura}/share/zathura/themes/catppuccin-macchiato
    '';
  };
}
