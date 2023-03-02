local wk = require("which-key")

vim.keymap.set("n", "<leader>mm", "<Plug>MarkdownPreview", { remap = true, desc = "Preview" })
vim.keymap.set("n", "<leader>ms", "<Plug>MarkdownPreviewStop", { remap = true, desc = "Stop previewing" })
vim.keymap.set("n", "<leader>mt", "<Plug>MarkdownPreviewToggle", { remap = true, desc = "Toggle preview" })
wk.register({ ["<leader>m"] = "Markdown" })
