local tint = require("tint")
local transforms = require("tint.transforms")
local cp = require("catppuccin.palettes").get_palette()

tint.setup({
   highlight_ignore_patterns = { "WinSeparator", "EndOfBuffer" },
   transforms = {
      transforms.tint_with_threshold(-50, cp.base, 50),
      transforms.saturate(0.5),
   },
})

vim.keymap.set("n", "<leader>ni", tint.toggle, { desc = "Toggle tint" })
