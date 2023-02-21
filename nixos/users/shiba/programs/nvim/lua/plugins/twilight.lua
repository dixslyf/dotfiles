local twilight = require("twilight")

twilight.setup()

vim.keymap.set("n", "<leader>tt", twilight.toggle, { desc = "Toggle twilight" })
