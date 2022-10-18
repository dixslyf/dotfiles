local tint = require("tint")

tint.setup({
   tint = -50,
   saturation = 0.5,
})

vim.keymap.set("n", "<leader>ti", tint.toggle, { desc = "Toggle tint" })
