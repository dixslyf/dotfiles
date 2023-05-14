{ localFlakeInputs', ... }:
{ config
, lib
, pkgs
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.neovim = {
        enable = mkEnableOption "planet neovim";
        rustToolchain = mkOption {
          type = types.package;
          default = localFlakeInputs'.fenix.packages.stable.withComponents [
            # Minimal
            "rustc"
            "rust-std"
            "cargo"

            # Default
            "rust-docs"
            "rustfmt"
            "clippy"

            # Extra
            "rust-analyzer"
            "rust-src"
          ];
          description = "Rust toolchain to use.";
        };
        nilPackage = mkOption {
          type = types.package;
          default = pkgs.nil;
          description = "The `nil` package to use.";
        };
      };
    };

  config =
    let
      cfg = config.planet.neovim;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      xdg.configFile."nvim/lua".source = ./lua;
      programs.neovim = {
        enable = true;
        extraLuaConfig = ''
          Globals = {
             cppdbg_command = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7",
          }
          require("options")
          require("plugins")
        '';
        extraPackages = with pkgs; [
          ripgrep # Used by telescope
          editorconfig-checker
          shellcheck
          shfmt
          sumneko-lua-language-server
          stylua
          fnlfmt
          nixpkgs-fmt
          cfg.nilPackage
          gcc
          clang-tools
          ghc
          haskell-language-server
          ormolu
          haskellPackages.cabal-fmt
          proselint
          ltex-ls
          statix
          deadnix
          actionlint
          yamllint
          nodePackages.prettier
          cfg.rustToolchain
          (texlive.combine {
            inherit (texlive) scheme-minimal latexindent;
          })
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
        ] ++ lib.lists.optionals config.planet.bspwm.enable [ xclip ]
        ++ lib.lists.optionals config.planet.hyprland.enable [ wl-clipboard ];
        plugins = with pkgs.vimPlugins;
          [
            leap-nvim
            indent-blankline-nvim
            nvim-ufo
            catppuccin-nvim
            nvim-colorizer-lua
            feline-nvim
            nvim-navic
            telescope-nvim
            telescope-fzf-native-nvim
            dressing-nvim
            nvim-web-devicons
            twilight-nvim
            tint-nvim
            nvim-autopairs
            nvim-lspconfig
            nvim-dap
            nvim-dap-ui
            neodev-nvim
            null-ls-nvim
            lspkind-nvim
            nvim-cmp
            cmp_luasnip
            cmp-nvim-lsp
            cmp-nvim-lsp-signature-help
            cmp-nvim-lsp-document-symbol
            cmp-treesitter
            cmp-buffer
            cmp-path
            cmp-cmdline
            cmp-nvim-lua
            cmp-dap
            cmp-latex-symbols
            editorconfig-nvim
            which-key-nvim
            hydra-nvim
            gitsigns-nvim
            luasnip
            vim-snippets
            todo-comments-nvim
            markdown-preview-nvim
            vimtex
            nvim-neoclip-lua
            (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
              with plugins; [
                tree-sitter-bash
                tree-sitter-c
                tree-sitter-cpp
                tree-sitter-fennel
                tree-sitter-haskell
                tree-sitter-html
                tree-sitter-javascript
                tree-sitter-json
                tree-sitter-lua
                tree-sitter-markdown
                tree-sitter-markdown-inline
                tree-sitter-nix
                tree-sitter-python
                tree-sitter-rust
                tree-sitter-toml
                tree-sitter-vim
              ]))
          ];
      };
    };
}
