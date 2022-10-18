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
  leap-nvim = build "leap-nvim";
  plenary-nvim = build "plenary-nvim";
  catppuccin-nvim = build "catppuccin-nvim";
  feline-nvim = build "feline-nvim";
  telescope-nvim = build "telescope-nvim";
  dressing-nvim = build "dressing-nvim";
  nvim-web-devicons = build "nvim-web-devicons";
  nvim-lspconfig = build "nvim-lspconfig";
  null-ls-nvim = build "null-ls-nvim";
  neodev-nvim = build "neodev-nvim";
  editorconfig-nvim = build "editorconfig-nvim";
  which-key-nvim = build "which-key-nvim";
  hydra-nvim = build "hydra-nvim";
  gitsigns-nvim = build "gitsigns-nvim";
}
