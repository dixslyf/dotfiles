{
  pkgs,
  ...
}:
{
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
    git = {
      enable = true;
      profile = "personal";
    };
    ssh.enable = true;
  };

  home.packages = with pkgs; [
    eza
    fd
    ripgrep
    neofetch
    bottom
  ];
}
