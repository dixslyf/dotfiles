local M = {}

function M.setup()
   require("plugins.leap").setup()
   require("plugins.indent-blankline").setup()
   require("plugins.catppuccin").setup()
   require("plugins.colorizer").setup()
   require("plugins.treesitter").setup()
   require("plugins.feline").setup()
   require("plugins.tint").setup()
   require("plugins.twilight").setup()
   require("plugins.autopairs").setup()
   require("plugins.telescope").setup()
   require("plugins.dressing").setup()
   require("plugins.lspconfig").setup()
   require("plugins.ufo").setup()
   require("plugins.dap").setup()
   require("plugins.which-key")
   require("plugins.gitsigns").setup()
   require("plugins.luasnip").setup()
   require("plugins.todo-comments").setup()
   require("plugins.markdown-preview").setup()
   require("plugins.vimtex")
   require("plugins.cmp").setup()
   require("plugins.neoclip").setup()
   require("plugins.zk")
end

return M
