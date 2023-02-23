_: {
  flake =
    let
      sources = import ./npins;
    in
    {
      overlays.pers-pkgs = _: prev: {
        inherit sources;
        pers-pkgs = {
          nvidia-offload = prev.callPackage ./nvidia-offload { };
          bspwm = prev.callPackage ./bspwm { };
          sddm-sugar-candy = prev.callPackage ./sddm-sugar-candy { };
          catppuccin-fish = prev.callPackage ./catppuccin-fish { };
          catppuccin-gitui = prev.callPackage ./catppuccin-gitui { };
          catppuccin-papirus-icon-theme = prev.callPackage ./catppuccin-papirus { };
          catppuccin-papirus-folders = prev.callPackage ./catppuccin-papirus-folders { };
          catppuccin-rofi-basic = prev.callPackage ./catppuccin-rofi-basic { };
          catppuccin-polybar = prev.callPackage ./catppuccin-polybar { };
          catppuccin-waybar = prev.callPackage ./catppuccin-waybar { };
          catppuccin-mako = prev.callPackage ./catppuccin-mako { };
          catppuccin-zathura = prev.callPackage ./catppuccin-zathura { };
          wlsunset = prev.callPackage ./wlsunset { };
          mali = prev.callPackage ./mali { };
          # vimPlugins = prev.lib.recurseIntoAttrs (prev.callPackage ./vim-plugins {});
          waybar = prev.callPackage ./waybar { };
        };
      };
    };
}
