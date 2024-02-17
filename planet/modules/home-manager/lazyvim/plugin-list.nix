{ lib, vimPlugins, localFlakePackages' }:

let
  mkPluginDesc = plugin:
    let
      # Example of gitRepoUrl: https://github.com/folke/lazy.nvim.git
      url = plugin.src.gitRepoUrl;
      urlLength = builtins.stringLength url;

      # `(urlLength - 4)` to get rid of the ".git" at the end of the URL.
      urlParts = lib.splitString "/" (builtins.substring 0 (urlLength - 4) url);
      urlPartsLength = builtins.length urlParts;

      # Get the repo name. E.g., "lazy.nvim"
      name = builtins.elemAt urlParts (urlPartsLength - 1);

      # Append the repo owner to the repo name. E.g., "folke/lazy.nvim"
      shortUrl = "${builtins.elemAt urlParts (urlPartsLength - 2)}/${name}";
    in
    {
      inherit shortUrl name plugin;
    };
  mkMiniPluginDesc = name: {
    inherit name;
    shortUrl = "echasnovski/${name}";
    plugin = localFlakePackages'."vimPlugins/${name}";
  };
in
(builtins.map mkPluginDesc (with vimPlugins; [
  LazyVim

  bufferline-nvim
  conform-nvim
  dashboard-nvim
  dressing-nvim
  flash-nvim
  friendly-snippets
  gitsigns-nvim
  indent-blankline-nvim
  luasnip
  lualine-nvim
  mason-nvim
  mason-lspconfig-nvim
  mini-nvim
  neoconf-nvim
  neodev-nvim
  neo-tree-nvim
  noice-nvim
  nui-nvim
  nvim-lint
  nvim-lspconfig
  nvim-notify
  nvim-spectre

  # nvim-cmp
  nvim-cmp
  cmp-buffer
  cmp_luasnip
  cmp-nvim-lsp
  cmp-path

  # treesitter
  (vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
    tree-sitter-bash
    tree-sitter-c
    tree-sitter-cpp
    tree-sitter-fennel
    tree-sitter-haskell
    tree-sitter-html
    tree-sitter-java
    tree-sitter-javascript
    tree-sitter-json
    tree-sitter-lua
    tree-sitter-markdown
    tree-sitter-markdown-inline
    tree-sitter-nix
    tree-sitter-python
    tree-sitter-rust
    tree-sitter-toml
    tree-sitter-typst
    tree-sitter-vim
  ]))
  nvim-treesitter-context
  nvim-treesitter-textobjects
  nvim-ts-autotag

  nvim-web-devicons
  persistence-nvim
  plenary-nvim
  telescope-nvim
  todo-comments-nvim
  tokyonight-nvim
  trouble-nvim
  vim-illuminate
  vim-startuptime
  which-key-nvim
])) ++ (builtins.map mkMiniPluginDesc [
  # Nixpkgs only has the entire mini.nvim, but lazyvim uses the individual plugins.
  "mini.ai"
  "mini.bufremove"
  "mini.comment"
  "mini.indentscope"
  "mini.pairs"
  "mini.surround"
])
++ [
  {
    name = "catppuccin";
    shortUrl = "catppuccin/nvim";
    plugin = vimPlugins.catppuccin-nvim;
  }
  {
    # Not strictly necessary, but in Nixpkgs, the repo owner is in lowercase while
    # in LazyVim, it is in uppercase, which causes lazy.nvim to warn about different URLS.
    name = "nvim-ts-context-commentstring";
    shortUrl = "JoosepAlviste/nvim-ts-context-commentstring";
    plugin = vimPlugins.nvim-ts-context-commentstring;
  }
]
