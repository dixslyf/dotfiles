local M = {}

local twilight = require("twilight")
local wk = require("which-key")

function M.setup()
   wk.add({ { "<leader>n", group = "Dim" } })
   twilight.setup()
   vim.keymap.set("n", "<leader>nt", twilight.toggle, { desc = "Toggle twilight" })
end

return M
