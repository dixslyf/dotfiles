local twilight = require("twilight")
local wk = require("which-key")
wk.register({ ["<leader>n"] = "Dim" })

twilight.setup()
vim.keymap.set("n", "<leader>nt", twilight.toggle, { desc = "Toggle twilight" })
