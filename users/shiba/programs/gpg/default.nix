_: {
  programs.gpg.enable = true;
  home.persistence."/persist/home/shiba".directories = [ ".gnupg" ];
}
