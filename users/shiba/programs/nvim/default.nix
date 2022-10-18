{pkgs, ...}: {
  xdg.configFile."nvim/lua".source = ./lua;
  xdg.configFile."nvim/config.lua".source = ./config.lua;
  programs.neovim = {
    enable = true;
    extraConfig = ''
      luafile ~/.config/nvim/config.lua
    '';
    plugins = with pkgs.pvtpkgs.vimPlugins; [
      leap-nvim
      plenary-nvim
      catppuccin-nvim
      feline-nvim
      telescope-nvim
      dressing-nvim
      nvim-web-devicons
      tint-nvim
      nvim-lspconfig
      null-ls-nvim
      neodev-nvim
      editorconfig-nvim
      which-key-nvim
      hydra-nvim
      gitsigns-nvim
    ] ++ [
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
    ];
    extraPackages = with pkgs; [
      rnix-lsp
      sumneko-lua-language-server
    ];
  };
}
