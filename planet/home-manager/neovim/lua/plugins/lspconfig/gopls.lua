local M = {}

function M.setup(capabilities)
   vim.lsp.enable("gopls")
   vim.lsp.config("gopls", {
      capabilities = capabilities,
   })
end

return M
