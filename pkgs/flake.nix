{
  description = "Private Nix flakes";

  inputs = {
    catppuccin-macchiato-dark-cursors = {
      url = "https://github.com/catppuccin/cursors/raw/main/cursors/Catppuccin-Macchiato-Dark-Cursors.zip";
      flake = false;
    };
  };

  outputs = inputs @ {...}: {
    overlay = final: prev: {
      inherit inputs;
      pvtpkgs = {
        catppuccin-macchiato-dark-cursors = final.callPackage ./catppuccin-macchiato-dark-cursors {};
      };
    };
  };
}
