{pkgs, ...}: {
  programs.gitui = {
    enable = true;
    keyConfig = builtins.readFile ./key_bindings.ron;
    theme = builtins.readFile "${pkgs.pvtpkgs.catppuccin-gitui}/share/gitui/macchiato.ron";
  };
}
