{pkgs, ...}: {
  programs.mako = {
    enable = true;
    anchor = "bottom-right";
    defaultTimeout = 8000;
    font = "Mali 16";
    maxIconSize = 48;
    width = 400;
    height = 200;
    margin = "12";
    padding = "16";
    borderRadius = 4;
    borderSize = 3;
    extraConfig = builtins.readFile "${pkgs.pvtpkgs.catppuccin-mako}/share/mako/themes/catppuccin/macchiato";
  };
}
