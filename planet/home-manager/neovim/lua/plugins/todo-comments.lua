local M = {}

local todo = require("todo-comments")
local telescope = require("telescope")

function M.setup()
   todo.setup({
      highlight = {
         -- Sometimes there are todos in strings, especially in Nix
         -- where strings may be bash and the todos are actually bash comments
         comments_only = false,
      },
   })

   vim.keymap.set("n", "<leader>ft", telescope.extensions["todo-comments"].todo, { desc = "Todo comments" })
   vim.keymap.set("n", "]t", todo.jump_next, { desc = "Next todo comment" })
   vim.keymap.set("n", "[t", todo.jump_prev, { desc = "Previous todo comment" })
end

return M
