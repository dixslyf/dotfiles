local M = {}

local lspconfig = require("lspconfig")
function M.setup(on_attach, capabilities)
   -- Enable completion using snippets
   capabilities.textDocument.completion.completionItem.snippetSupport = true
   lspconfig.html.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
         provideFormatter = false, -- Let Prettier do the formatting
      },
   })
end

return M
