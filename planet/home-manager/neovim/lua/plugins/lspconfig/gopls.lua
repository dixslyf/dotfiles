local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("gopls")
   vim.lsp.config("gopls", {
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
