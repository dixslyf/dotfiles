local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("astro")
   vim.lsp.config("astro", {
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
