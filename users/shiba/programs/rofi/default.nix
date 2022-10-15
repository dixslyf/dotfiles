{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "Mali 16";
    terminal = "${pkgs.kitty}/bin/kitty";
    extraConfig = {
      m = -1;
      steal-focus = true;
      kb-row-up = "Up,Alt+k";
      kb-row-down = "Down,Alt+j";
      kb-row-left = "Alt+h";
      kb-row-right = "Alt+l";
    };
  };
}
