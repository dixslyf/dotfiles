local M = {}

local wk = require("which-key")

function M.setup()
   wk.add({ { "<leader>m", group = "Markdown" } })
   vim.keymap.set("n", "<leader>mm", "<Plug>MarkdownPreview", { remap = true, desc = "Preview" })
   vim.keymap.set("n", "<leader>ms", "<Plug>MarkdownPreviewStop", { remap = true, desc = "Stop previewing" })
   vim.keymap.set("n", "<leader>mt", "<Plug>MarkdownPreviewToggle", { remap = true, desc = "Toggle preview" })
end

return M
