local M = {}

function M.setup(capabilities)
   -- Enable completion using snippets
   capabilities.textDocument.completion.completionItem.snippetSupport = true
   vim.lsp.enable("jsonls")
   vim.lsp.config("jsonls", {
      capabilities = capabilities,
      init_options = {
         provideFormatter = false, -- Let Prettier do the formatting
      },
   })
end

return M
