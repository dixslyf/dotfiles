_: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.persistence."/persist/home/shiba".directories = [
    ".local/share/direnv"
  ];
}
