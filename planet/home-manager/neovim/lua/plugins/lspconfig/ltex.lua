local M = {}

function M.setup(capabilities)
   vim.lsp.enable("ltex")
   vim.lsp.config("ltex", {
      capabilities = capabilities,
      settings = {
         ltex = {
            language = "en-GB",
         },
      },
   })
end

return M
