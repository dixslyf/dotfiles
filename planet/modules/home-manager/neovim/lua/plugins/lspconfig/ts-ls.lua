local M = {}

local lspconfig = require("lspconfig")
function M.setup(on_attach, capabilities)
   -- Let Prettier do the formatting
   capabilities.document_formatting = false
   capabilities.document_range_formatting = false
   lspconfig.ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
