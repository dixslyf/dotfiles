local M = {}

function M.setup(capabilities)
   capabilities.offsetEncoding = { "utf-16" }
   vim.lsp.enable("clangd")
   vim.lsp.config("clangd", {
      capabilities = capabilities,
   })
end

return M
