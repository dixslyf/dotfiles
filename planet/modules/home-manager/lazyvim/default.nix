{ localFlake', ... }:
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
      planet.lazyvim = {
        enable = mkEnableOption "planet lazyvim";
        package = mkOption {
          type = types.package;
          default = pkgs.neovim-unwrapped;
          description = "The `neovim` package to use.";
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
      cfg = config.planet.lazyvim;
      inherit (lib) mkIf;

      plugins-no-rename = (with pkgs.vimPlugins; [
        bufferline-nvim

        # nvim-cmp
        nvim-cmp
        cmp-buffer
        cmp_luasnip
        cmp-nvim-lsp
        cmp-path

        conform-nvim
        dashboard-nvim
        dressing-nvim
        flash-nvim
        friendly-snippets
        gitsigns-nvim
        indent-blankline-nvim
        lazy-nvim
        LazyVim
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

        # treesitter
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
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
        nvim-ts-context-commentstring

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
      ]) ++ (builtins.map (plugin-name: localFlake'.packages."vimPlugins/${plugin-name}") [
        # Nixpkgs only has the entire mini.nvim, but lazyvim uses the individual plugins.
        "mini.ai"
        "mini.bufremove"
        "mini.comment"
        "mini.indentscope"
        "mini.pairs"
        "mini.surround"
      ]);

      plugins-rename = with pkgs.vimPlugins; {
        catppuccin = catppuccin-nvim;
        LuaSnip = luasnip;
      };
    in
    mkIf cfg.enable {
      xdg = {
        configFile = {
          "nvim/.neoconf.json".source = ./.neoconf.json;
          "nvim/lua".source = ./lua;
        };
        mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
          lib.genAttrs cfg.defaultApplication.mimeTypes (_: "nvim.desktop")
        );
      };

      home.file = (builtins.listToAttrs (
        builtins.map
          (plugin: {
            name = ".local/share/nvim/lazy/${plugin.pname}";
            value = {
              source = "${plugin}";
              recursive = true;
            };
          })
          plugins-no-rename
      )) // builtins.listToAttrs (
        builtins.attrValues (
          builtins.mapAttrs
            (plugin-name: plugin: {
              name = ".local/share/nvim/lazy/${plugin-name}";
              value = {
                source = "${plugin}";
                recursive = true;
              };
            })
            plugins-rename
        )
      );

      programs.neovim = {
        inherit (cfg) package;
        enable = true;
        vimAlias = true;
        viAlias = true;
        defaultEditor = true;
        extraLuaConfig = builtins.readFile ./init.lua;
      };
    };
}
