-- zk
local zk_util = require("zk.util")
if zk_util.notebook_root(vim.fn.expand("%:p")) ~= nil then
   -- Overrides the global mapping to create the note in the same directory as the current buffer
   vim.keymap.set(
      "n",
      "<leader>zn",
      "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
      { desc = "Create note", buffer = true }
   )

   -- Create note using the current selection as title
   vim.keymap.set(
      "v",
      "<leader>zn",
      ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>",
      { desc = "Create note", buffer = true }
   )

   -- Open the link under the caret.
   vim.keymap.set("n", "zo", "<Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Open link", buffer = true })

   -- Find notes linking to the current buffer.
   local tls_builtin = require("telescope.builtin")
   vim.keymap.set("n", "<leader>zfb", function()
      tls_builtin.lsp_references({ jump_type = "never" })
   end, { desc = "Backlinks", buffer = true })

   -- Find notes linked to by the current buffer.
   vim.keymap.set("n", "<leader>zfl", "<Cmd>ZkLinks<CR>", { desc = "Links", buffer = true })
end
