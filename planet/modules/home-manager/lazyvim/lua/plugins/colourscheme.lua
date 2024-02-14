return {
   {
      "LazyVim/LazyVim",
      opts = { colorscheme = "catppuccin" },
   },

   {
      "catppuccin/nvim",
      -- For some reason, this has to be set again
      -- even though it's already set by LazyVim.
      name = "catppuccin",
      opts = { flavour = "macchiato" },
   },
}
