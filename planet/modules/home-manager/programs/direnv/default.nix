_: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  planet.persistence = {
    directories = [
      ".local/share/direnv"
    ];
  };
}
