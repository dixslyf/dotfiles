vim.g.catppuccin_flavour = "macchiato"

require("catppuccin").setup {
    dim_inactive = { enabled = true }
}

vim.cmd [[colorscheme catppuccin]]
