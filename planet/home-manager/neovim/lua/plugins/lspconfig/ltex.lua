local M = {}

function M.setup(capabilities)
   vim.lsp.enable("ltex_plus")
   vim.lsp.config("ltex_plus", {
      capabilities = capabilities,
      settings = {
         ltex = {
            language = "en-GB",
         },
      },
   })
end

return M
