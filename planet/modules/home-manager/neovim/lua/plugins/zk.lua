local zk = require("zk")
zk.setup({
   picker = "telescope",
})

local wk = require("which-key")
wk.register({
   ["<leader>z"] = {
      name = "Zk",
      f = "Find",
   },
})

-- TODO: only set the key bindings when the current directory within a notebook

-- Create a new note after asking for its title.
vim.keymap.set("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { desc = "Create note" })

-- Find notes.
vim.keymap.set("n", "<leader>zff", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { desc = "Notes" })

-- Find notes associated with the selected tags.
vim.keymap.set("n", "<leader>zft", "<Cmd>ZkTags<CR>", { desc = "Notes (tag)" })

-- Find notes matching a given query.
vim.keymap.set(
   "n",
   "<leader>zfs",
   "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
   { desc = "Notes (query)" }
)

-- Find notes matching the current visual selection.
vim.keymap.set("v", "<leader>zf", ":'<,'>ZkMatch<CR>", { desc = "Notes (current visual selection)" })

-- More bindings are set in the ftplugin for markdown
