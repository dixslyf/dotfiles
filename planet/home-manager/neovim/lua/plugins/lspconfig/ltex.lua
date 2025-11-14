local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("ltex")
   vim.lsp.config("ltex", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         ltex = {
            language = "en-GB",
         },
      },
   })
end

return M
