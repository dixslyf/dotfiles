vim.g.catppuccin_flavour = "macchiato"

require("catppuccin").setup({
   compile_path = vim.fn.stdpath "cache" .. "/catppuccin-nvim"
})

vim.cmd([[colorscheme catppuccin]])
