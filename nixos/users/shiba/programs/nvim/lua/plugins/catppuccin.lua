vim.g.catppuccin_flavour = "macchiato"

require("catppuccin").setup({
   compile_path = vim.fn.stdpath("cache") .. "/catppuccin-nvim",
   integrations = {
      indent_blankline = {
         enabled = true,
         colored_indent_levels = false,
      },
   },
})

vim.cmd([[colorscheme catppuccin]])
