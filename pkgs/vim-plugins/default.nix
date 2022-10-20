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
  plugins = [
    "leap-nvim"
    "plenary-nvim"
    "catppuccin-nvim"
    "feline-nvim"
    "nvim-web-devicons"
    "tint-nvim"
    "twilight-nvim"
    "nvim-autopairs"
    "nvim-navic"
    "telescope-nvim"
    "dressing-nvim"
    "nvim-lspconfig"
    "null-ls-nvim"
    "neodev-nvim"
    "editorconfig-nvim"
    "which-key-nvim"
    "hydra-nvim"
    "gitsigns-nvim"
  ];
in
  builtins.listToAttrs (map (p: {
      name = p;
      value = build p;
    })
    plugins)
