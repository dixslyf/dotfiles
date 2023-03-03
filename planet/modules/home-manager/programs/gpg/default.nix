_: {
  programs.gpg.enable = true;
  planet.persistence = {
    directories = [ ".gnupg" ];
  };
}
