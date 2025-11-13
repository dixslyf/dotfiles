local M = {}

local dressing = require("dressing")
local tls_themes = require("telescope.themes")

function M.setup()
   dressing.setup({
      select = {
         telescope = tls_themes.get_cursor(),
      },
   })
end

return M
