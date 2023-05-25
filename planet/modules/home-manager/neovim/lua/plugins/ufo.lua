local M = {}

local ufo = require("ufo")
function M.setup()
   vim.o.foldcolumn = "1"
   vim.o.foldlevel = 99
   vim.o.foldlevelstart = 99
   vim.o.foldenable = true

   vim.keymap.set("n", "zR", ufo.openAllFolds)
   vim.keymap.set("n", "zM", ufo.closeAllFolds)

   ufo.setup()
end

return M
