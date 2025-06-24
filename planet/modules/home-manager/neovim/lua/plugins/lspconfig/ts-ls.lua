local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("ts_ls")
   vim.lsp.config("ts_ls", {
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
