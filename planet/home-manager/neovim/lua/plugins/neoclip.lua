local M = {}

local neoclip = require("neoclip")
local telescope = require("telescope")
function M.setup()
   neoclip.setup({
      default_register = { '"', "+" },
      keys = {
         telescope = {
            i = {
               paste_behind = "<c-b>",
            },
         },
      },
   })

   vim.keymap.set("n", "<leader>v", telescope.extensions["neoclip"].neoclip, { desc = "Neoclip" })
end

return M
