{pkgs, ...}: {
  xdg.configFile."nvim/lua".source = ./lua;
  xdg.configFile."nvim/config.lua".source = ./config.lua;
  programs.neovim = {
    enable = true;
    extraConfig = ''
      luafile ~/.config/nvim/config.lua
    '';
    plugins = with pkgs.vimPlugins; [
      leap-nvim
      plenary-nvim
      catppuccin-nvim
      feline-nvim
      telescope-nvim
      dressing-nvim
      nvim-web-devicons
      twilight-nvim
      nvim-autopairs
      nvim-lspconfig
      null-ls-nvim
      editorconfig-nvim
      which-key-nvim
      hydra-nvim
      gitsigns-nvim
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: [
        plugins.tree-sitter-bash
        plugins.tree-sitter-c
        plugins.tree-sitter-cpp
        plugins.tree-sitter-lua
        plugins.tree-sitter-nix
        plugins.tree-sitter-rust
        plugins.tree-sitter-toml
        plugins.tree-sitter-vim
      ]))
    ] ++ (with pkgs.pvtpkgs.vimPlugins; [
      tint-nvim
      nvim-navic
      neodev-nvim
    ]);
    extraPackages = with pkgs; [
      rnix-lsp
      sumneko-lua-language-server
    ];
  };
}
