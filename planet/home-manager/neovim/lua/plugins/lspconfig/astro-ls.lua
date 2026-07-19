local M = {}

function M.setup(capabilities)
   vim.lsp.enable("astro")
   vim.lsp.config("astro", {
      capabilities = capabilities,
   })
end

return M
