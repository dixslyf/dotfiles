vim.g.catppuccin_flavour = "macchiato"

require("catppuccin").setup({
   compile_path = vim.fn.stdpath("cache") .. "/catppuccin-nvim",
   integrations = {
      gitsigns = true,
      indent_blankline = {
         enabled = true,
         colored_indent_levels = false,
      },
      leap = true,
      markdown = true,
      cmp = true,
      dap = {
         enabled = true,
         enable_ui = true,
      },
      native_lsp = {
         enabled = true,
         virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
         },
         underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
         },
      },
      navic = {
         enabled = true,
      },
      treesitter = true,
      telescope = true,
      which_key = true,
   },
})

vim.cmd([[colorscheme catppuccin]])
