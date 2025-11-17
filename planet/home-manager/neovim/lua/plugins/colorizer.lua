local M = {}

local colorizer = require("colorizer")
function M.setup()
   colorizer.setup({
      user_default_options = {
         RRGGBBAA = true,
         css = true,
         css_fn = true,
         sass = { enable = true, parsers = { "css" } },
      },
   })
end

return M
