vim.g.catppuccin_flavour = "frappe"

require("catppuccin").setup {
    dim_inactive = { enabled = true }
}

vim.cmd [[colorscheme catppuccin]]
