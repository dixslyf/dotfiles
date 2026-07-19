local M = {}

local lazydev = require("lazydev")
function M.setup(capabilities)
   lazydev.setup()

   vim.lsp.enable("lua_ls")
   vim.lsp.config("lua_ls", {
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
