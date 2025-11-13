local M = {}

local leap = require("leap")
function M.setup()
   leap.add_default_mappings()
end

return M
