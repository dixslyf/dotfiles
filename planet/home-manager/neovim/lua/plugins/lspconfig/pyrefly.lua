local M = {}

function M.setup(capabilities)
   vim.lsp.enable("pyrefly")
   vim.lsp.config("pyrefly", {
      capabilities = capabilities,
   })
end

return M
