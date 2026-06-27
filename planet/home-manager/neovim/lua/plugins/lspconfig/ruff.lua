local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("ruff")
   vim.lsp.config("ruff", {
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
