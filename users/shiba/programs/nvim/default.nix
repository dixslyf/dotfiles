{pkgs, ...}: {
  xdg.configFile."nvim/lua".source = ./lua;
  xdg.configFile."nvim/config.lua".source = pkgs.substituteAll {
    src = ./config.lua;
    cppdbgCommand = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";
  };
  programs.neovim = {
    enable = true;
    extraConfig = ''
      luafile ~/.config/nvim/config.lua
    '';
    extraPackages = with pkgs; [
      (python3.withPackages (pyPkgs:
        with pyPkgs; [
          python-lsp-server
          python-lsp-black
          pyls-isort
          pylsp-mypy
          flake8
          flake8-bugbear
          rope
        ]))
    ];
    plugins = with pkgs.vimPlugins;
      [
        leap-nvim
        catppuccin-nvim
        nvim-colorizer-lua
        feline-nvim
        nvim-navic
        telescope-nvim
        telescope-fzf-native-nvim
        dressing-nvim
        nvim-web-devicons
        twilight-nvim
        nvim-autopairs
        nvim-lspconfig
        nvim-dap
        nvim-dap-ui
        neodev-nvim
        null-ls-nvim
        lspkind-nvim
        editorconfig-nvim
        which-key-nvim
        hydra-nvim
        gitsigns-nvim
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
          with plugins; [
            tree-sitter-bash
            tree-sitter-c
            tree-sitter-cpp
            tree-sitter-lua
            tree-sitter-nix
            tree-sitter-python
            tree-sitter-rust
            tree-sitter-toml
            tree-sitter-vim
          ]))
      ]
      ++ (with pkgs.pvtpkgs.vimPlugins; [
        tint-nvim
      ]);
  };
}
