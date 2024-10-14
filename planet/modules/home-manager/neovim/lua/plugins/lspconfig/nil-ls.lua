local M = {}

local lspconfig = require("lspconfig")
function M.setup(on_attach, capabilities)
   lspconfig.nil_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         ["nil"] = {
            formatting = {
               command = { "nixfmt" },
            },
         },
      },
   })
end

return M
