local M = {}

local neodev = require("neodev")
function M.setup(on_attach, capabilities)
   neodev.setup()

   vim.lsp.enable("lua_ls")
   vim.lsp.config("lua_ls", {
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
