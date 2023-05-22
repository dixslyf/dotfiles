local M = {}

local neodev = require("neodev")
local lspconfig = require("lspconfig")
function M.setup(on_attach, capabilities)
   neodev.setup()

   lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         Lua = {
            format = {
               enable = false,
            },
         },
      },
   })
end

return M
