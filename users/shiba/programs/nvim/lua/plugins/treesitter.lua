local ts_configs = require("nvim-treesitter.configs")
ts_configs.setup({
   -- Work around https://github.com/NixOS/nixpkgs/issues/189838
   ensure_installed = {},
   highlight = {
      enable = true,
   },
   incremental_selection = {
      enable = true,
      keymaps = {
         init_selection = "gnn",
         node_incremental = "grn",
         scope_incremental = "grc",
         node_decremental = "grm",
      },
   },
})
