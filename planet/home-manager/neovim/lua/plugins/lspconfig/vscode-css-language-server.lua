local M = {}

function M.setup(on_attach, capabilities)
   -- Enable completion using snippets
   capabilities.textDocument.completion.completionItem.snippetSupport = true
   vim.lsp.enable("cssls")
   vim.lsp.config("cssls", {
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
         provideFormatter = false, -- Let Prettier do the formatting
      },
   })
end

return M
