local neoclip = require("neoclip")
neoclip.setup({
   default_register = { '"', "+" },
   keys = {
      telescope = {
         i = {
            paste_behind = "<c-b>",
         },
      },
   },
})

local telescope = require("telescope")
vim.keymap.set("n", "<leader>v", telescope.extensions["neoclip"].neoclip, { desc = "Neoclip" })
