local M = {}

local lspconfig = require("lspconfig")
function M.setup(on_attach, capabilities)
   lspconfig.hls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
