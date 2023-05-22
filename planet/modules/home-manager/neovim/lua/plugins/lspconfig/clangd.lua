local M = {}

local lspconfig = require("lspconfig")
function M.setup(on_attach, capabilities)
   capabilities.offsetEncoding = { "utf-16" }
   lspconfig.clangd.setup({
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
