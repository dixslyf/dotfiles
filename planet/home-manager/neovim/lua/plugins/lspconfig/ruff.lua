local M = {}

function M.setup(capabilities)
   vim.lsp.enable("ruff")
   vim.lsp.config("ruff", {
      capabilities = capabilities,
   })
end

return M
