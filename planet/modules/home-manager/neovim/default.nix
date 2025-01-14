{ localFlakeInputs', ... }:
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.neovim = {
        enable = mkEnableOption "planet neovim";
        package = mkOption {
          type = types.package;
          default = pkgs.neovim-unwrapped;
          description = "The `neovim` package to use.";
        };
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
        defaultApplication = {
          enable = mkEnableOption "MIME default application configuration";
          mimeTypes = mkOption {
            type = types.listOf types.str;
            default = [ "text/plain" ];
            description = ''
              MIME types to be the default application for.
            '';
          };
        };
      };
    };

  config =
    let
      cfg = config.planet.neovim;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      xdg = {
        configFile = {
          "nvim/lua".source = ./lua;
          "nvim/ftplugin".source = ./ftplugin;

          # See https://github.com/nvim-treesitter/nvim-treesitter#adding-queries.
          "nvim/queries/typst".source = "${pkgs.tree-sitter-grammars.tree-sitter-typst}/queries";
        };
        mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
          lib.genAttrs cfg.defaultApplication.mimeTypes (_: "nvim.desktop")
        );
      };

      programs.neovim = {
        inherit (cfg) package;
        enable = true;
        vimAlias = true;
        viAlias = true;
        defaultEditor = true;
        extraLuaConfig = builtins.readFile (
          pkgs.substituteAll {
            src = ./init.lua;
            cppdbg_command = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";
            jdt_ls = "${pkgs.jdt-language-server}/bin/jdtls";
            java_debug_server_dir = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server";
            java_test_server_dir = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server";
            vscode_eslint_language_server_node_path = "${pkgs.nodePackages.eslint}/lib/node_modules";
          }
        );
        extraPackages =
          with pkgs;
          [
            ripgrep # Used by telescope
            editorconfig-checker
            shellcheck
            shfmt
            sumneko-lua-language-server
            stylua
            fnlfmt
            nixfmt-rfc-style
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
            zk
            efm-langserver
            jq
            google-java-format
            tinymist
            typstyle
            cfg.rustToolchain
            nodePackages.typescript-language-server
            vscode-langservers-extracted
            htmlhint
            gopls
            (texlive.combine {
              inherit (texlive) scheme-minimal latexindent;
            })
            (python3.withPackages (
              pyPkgs: with pyPkgs; [
                python-lsp-server
                python-lsp-black
                pyls-isort
                pylsp-mypy
                flake8
                flake8-bugbear
                rope
              ]
            ))
          ]
          ++ lib.lists.optionals config.planet.bspwm.enable [ xclip ]
          ++ lib.lists.optionals config.planet.hyprland.enable [ wl-clipboard ];
        plugins = with pkgs.vimPlugins; [
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
          nvim-nio
          nvim-dap-ui
          neodev-nvim
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
          zk-nvim
          nvim-jdtls
          efmls-configs-nvim
          (pkgs.vimPlugins.nvim-treesitter.withPlugins (
            plugins: with plugins; [
              tree-sitter-bash
              tree-sitter-c
              tree-sitter-cpp
              tree-sitter-fennel
              tree-sitter-go
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
            ]
          ))
        ];
      };
    };
}
