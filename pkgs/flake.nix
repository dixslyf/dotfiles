{
  description = "Private Nix flakes";

  inputs = {
    catppuccin-macchiato-dark-cursors = {
      url = "https://github.com/catppuccin/cursors/raw/main/cursors/Catppuccin-Macchiato-Dark-Cursors.zip";
      flake = false;
    };
    catppuccin-nvim = {
      url = "github:catppuccin/nvim";
      flake = false;
    };
    feline-nvim = {
      url = "github:feline-nvim/feline.nvim";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:kyazdani42/nvim-web-devicons";
      flake = false;
    };
    hydra-nvim = {
      url = "github:anuvyklack/hydra.nvim";
      flake = false;
    };
  };

  outputs = inputs @ {...}: {
    overlay = final: prev: {
      inherit inputs;
      pvtpkgs = {
        catppuccin-macchiato-dark-cursors = final.callPackage ./catppuccin-macchiato-dark-cursors {};
        vimPlugins = final.lib.recurseIntoAttrs (final.callPackage ./vim-plugins {});
      };
    };
  };
}
