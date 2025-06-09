local M = {}

function M.setup(on_attach, capabilities)
   capabilities.offsetEncoding = { "utf-16" }
   vim.lsp.enable("clangd")
   vim.lsp.config("clangd", {
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
