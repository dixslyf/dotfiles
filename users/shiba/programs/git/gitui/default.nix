{pkgs, ...}: {
  programs.gitui = {
    enable = true;
    keyConfig = builtins.readFile ./key_bindings.ron;
    theme = builtins.readFile "${pkgs.pers-pkgs.catppuccin-gitui}/share/gitui/macchiato.ron";
  };
}
