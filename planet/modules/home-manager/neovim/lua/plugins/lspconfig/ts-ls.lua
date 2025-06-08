local M = {}

function M.setup(on_attach, capabilities)
   -- Let Prettier do the formatting
   capabilities.document_formatting = false
   capabilities.document_range_formatting = false
   vim.lsp.enable("ts_ls")
   vim.lsp.config("ts_ls", {
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
