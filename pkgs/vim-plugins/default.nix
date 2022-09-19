{
  inputs,
  vimUtils,
}: let
  build = name:
    vimUtils.buildVimPluginFrom2Nix rec {
      pname = name;
      version = src.lastModifiedDate;
      src = builtins.getAttr name inputs;
    };
in {
  catppuccin-nvim = build "catppuccin-nvim";
  feline-nvim = build "feline-nvim";
  nvim-web-devicons = build "nvim-web-devicons";
  hydra-nvim = build "hydra-nvim";
  gitsigns-nvim = build "gitsigns-nvim";
}
