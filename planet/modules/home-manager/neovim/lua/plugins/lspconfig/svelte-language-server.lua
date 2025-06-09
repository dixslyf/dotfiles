local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("svelte")
   vim.lsp.config("svelte", {
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
