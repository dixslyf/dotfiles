_: {
  programs.ssh.enable = true;
  planet.persistence = {
    directories = [ ".ssh" ];
  };
}
