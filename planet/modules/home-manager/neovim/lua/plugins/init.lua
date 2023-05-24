local M = {}

function M.setup()
   require("plugins.leap")
   require("plugins.indent-blankline")
   require("plugins.catppuccin").setup()
   require("plugins.colorizer").setup()
   require("plugins.treesitter")
   require("plugins.feline").setup()
   require("plugins.tint")
   require("plugins.twilight")
   require("plugins.autopairs").setup()
   require("plugins.telescope")
   require("plugins.dressing").setup()
   require("plugins.lspconfig").setup()
   require("plugins.ufo")
   require("plugins.dap").setup()
   require("plugins.which-key")
   require("plugins.gitsigns")
   require("plugins.luasnip")
   require("plugins.todo-comments")
   require("plugins.markdown-preview")
   require("plugins.vimtex")
   require("plugins.cmp").setup()
   require("plugins.neoclip")
   require("plugins.zk")
end

return M
