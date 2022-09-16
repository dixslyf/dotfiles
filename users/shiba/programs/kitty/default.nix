{ ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      shell = "fish";
    };
    font = {
      name = "Iosevka Term";
      size = 16;
    };
    theme = "Catppuccin-Macchiato";
  };
}
