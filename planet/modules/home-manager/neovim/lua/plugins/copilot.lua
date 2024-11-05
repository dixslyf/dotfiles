local M = {}

local copilot = require("copilot")
local copilot_chat = require("CopilotChat")
function M.setup()
   copilot.setup({})
   copilot_chat.setup({})
end

return M
