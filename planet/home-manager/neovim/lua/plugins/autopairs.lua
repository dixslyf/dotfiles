local M = {}

local autopairs = require("nvim-autopairs")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

function M.setup()
   autopairs.setup({ check_ts = true })
   cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done({
         filetypes = {
            tex = false,
         },
      })
   )
end

return M
