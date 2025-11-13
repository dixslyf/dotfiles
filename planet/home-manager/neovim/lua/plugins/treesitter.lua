local M = {}

local ts_configs = require("nvim-treesitter.configs")
local ts_parsers = require("nvim-treesitter.parsers")
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

   -- Add grammar for Typst.
   local parser_configs = ts_parsers.get_parser_configs()
   parser_configs.typst = {
      install_info = {
         url = "https://github.com/uben0/tree-sitter-typst",
         files = { "src/parser.c", "src/scanner.c" },
         generate_requires_npm = false,
         requires_generate_from_grammar = false,
      },
   }
   vim.treesitter.language.register("typst", "typst")
end

return M
