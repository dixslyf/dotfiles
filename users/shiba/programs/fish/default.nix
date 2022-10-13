{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      fish_config theme choose "Catppuccin Macchiato"
    '';
  };

  xdg.configFile."fish/themes" = {
    source = "${pkgs.pvtpkgs.catppuccin-fish}/share/fish/themes";
    recursive = true;
  };
}
