_: {
  flake =
    let
      sources = import ./npins;
    in
    {
      overlays.pers-pkgs = final: _: {
        inherit sources;
        pers-pkgs = {
          nvidia-offload = final.callPackage ./nvidia-offload { };
          bspwm = final.callPackage ./bspwm { };
          sddm-sugar-candy = final.callPackage ./sddm-sugar-candy { };
          catppuccin-fish = final.callPackage ./catppuccin-fish { };
          catppuccin-gitui = final.callPackage ./catppuccin-gitui { };
          catppuccin-papirus-icon-theme = final.callPackage ./catppuccin-papirus { };
          catppuccin-papirus-folders = final.callPackage ./catppuccin-papirus-folders { };
          catppuccin-rofi-basic = final.callPackage ./catppuccin-rofi-basic { };
          catppuccin-polybar = final.callPackage ./catppuccin-polybar { };
          catppuccin-waybar = final.callPackage ./catppuccin-waybar { };
          catppuccin-mako = final.callPackage ./catppuccin-mako { };
          catppuccin-zathura = final.callPackage ./catppuccin-zathura { };
          wlsunset = final.callPackage ./wlsunset { };
          mali = final.callPackage ./mali { };
          # vimPlugins = final.lib.recurseIntoAttrs (final.callPackage ./vim-plugins {});
          waybar = final.callPackage ./waybar { };
        };
      };
    };
}
