{
  description = "Private Nix flakes";

  inputs = {
    sddm-sugar-candy = {
      url = "git+https://framagit.org/MarianArlt/sddm-sugar-candy";
      flake = false;
    };
    catppuccin-fish = {
      url = "github:catppuccin/fish";
      flake = false;
    };
    catppuccin-gitui = {
      url = "github:catppuccin/gitui";
      flake = false;
    };
    catppuccin-gtk-macchiato-mauve = {
      type = "file"; # Work around nix#7083
      url = "https://github.com/catppuccin/gtk/raw/v-0.2.7/Releases/Catppuccin-Macchiato-Mauve.zip";
      flake = false;
    };
    catppuccin-papirus-folders = {
      url = "github:catppuccin/papirus-folders";
      flake = false;
    };
    catppuccin-rofi = {
      url = "github:catppuccin/rofi";
      flake = false;
    };
    catppuccin-waybar = {
      url = "github:catppuccin/waybar";
      flake = false;
    };
    catppuccin-mako = {
      url = "github:catppuccin/mako";
      flake = false;
    };
    catppuccin-zathura = {
      url = "github:catppuccin/zathura";
      flake = false;
    };
    wlsunset = {
      url = "sourcehut:~kennylevinsen/wlsunset";
      flake = false;
    };
    mali = {
      url = "github:cadsondemak/Mali";
      flake = false;
    };
    tint-nvim = {
      url = "github:levouh/tint.nvim";
      flake = false;
    };
  };

  outputs = inputs @ {...}: {
    overlay = final: prev: {
      inherit inputs;
      pvtpkgs = {
        sddm-sugar-candy = final.callPackage ./sddm-sugar-candy {};
        catppuccin-fish = final.callPackage ./catppuccin-fish {};
        catppuccin-gitui = final.callPackage ./catppuccin-gitui {};
        catppuccin-gtk-macchiato-mauve = final.callPackage ./catppuccin-gtk-macchiato-mauve {};
        catppuccin-papirus-icon-theme = final.callPackage ./catppuccin-papirus {};
        catppuccin-papirus-folders = final.callPackage ./catppuccin-papirus-folders {};
        catppuccin-rofi-basic = final.callPackage ./catppuccin-rofi-basic {};
        catppuccin-waybar = final.callPackage ./catppuccin-waybar {};
        catppuccin-mako = final.callPackage ./catppuccin-mako {};
        catppuccin-zathura = final.callPackage ./catppuccin-zathura {};
        wlsunset = final.callPackage ./wlsunset {};
        mali = final.callPackage ./mali {};
        vimPlugins = final.lib.recurseIntoAttrs (final.callPackage ./vim-plugins {});
        waybar = final.callPackage ./waybar {};
      };
    };
  };
}
