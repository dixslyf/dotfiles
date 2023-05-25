local M = {}

local indent_blankline = require("indent_blankline")

function M.setup()
   indent_blankline.setup({
      char_priority = 50, -- For compatibility with ufo
   })
end

return M
