{ inputs, ... }:

{
  imports = [ inputs.hyprland.homeManagerModules.default ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;  # required to use the nixOS module to install hyprland
    xwayland.enable = true;
    # use extraConfig so that the hyprland flake still adds in the lines for systemd integration
    extraConfig = builtins.readFile ./hyprland.conf;
  };
}
