_: {
  programs.ssh.enable = true;
  home.persistence."/persist/home/shiba".directories = [ ".ssh" ];
}
