local M = {}

function M.setup(capabilities)
   vim.lsp.enable("svelte")
   vim.lsp.config("svelte", {
      capabilities = capabilities,
   })
end

return M
