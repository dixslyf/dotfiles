local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("pyrefly")
   vim.lsp.config("pyrefly", {
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
