local M = {}

local lspconfig = require("lspconfig")
function M.setup(on_attach, capabilities)
   lspconfig.ltex.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         ltex = {
            language = "en-GB",
         },
      },
   })
end

return M
