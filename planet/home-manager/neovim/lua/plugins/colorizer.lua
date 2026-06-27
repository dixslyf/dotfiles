local M = {}

local colorizer = require("colorizer")
function M.setup()
   colorizer.setup({
      options = {
         parsers = {
            css = true,
            hex = { rrggbbaa = true },
            tailwind = { enable = true },
         },
      },
   })
end

return M
