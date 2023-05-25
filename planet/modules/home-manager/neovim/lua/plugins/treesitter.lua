local M = {}

local ts_configs = require("nvim-treesitter.configs")
function M.setup()
   ts_configs.setup({
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
end

return M
