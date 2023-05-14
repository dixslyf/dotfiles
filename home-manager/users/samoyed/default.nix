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

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        insert_final_newline = true;
        trim_trailing_whitespace = true;
        indent_style = "space";
      };
      "*.nix" = { indent_size = 2; };
      "*.lua" = { indent_size = 3; };
    };
  };
}
