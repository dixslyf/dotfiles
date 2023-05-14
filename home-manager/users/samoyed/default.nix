{ pkgs
, ...
}: {
  home.stateVersion = "23.05";

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  systemd.user.startServices = "sd-switch";

  planet = {
    persistence = {
      enable = true;
      persistXdgUserDirectories = true;
    };
    editorconfig.enable = true;
    fish.enable = true;
    git.enable = true;
    ssh.enable = true;
  };

  home.packages = with pkgs; [
    exa
    fd
    ripgrep
    neofetch
    bottom
  ];
}
