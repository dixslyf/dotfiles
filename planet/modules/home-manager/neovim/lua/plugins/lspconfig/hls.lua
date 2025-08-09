local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("hls")
   vim.lsp.config("hls", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         haskell = {
            plugin = {
               rename = { config = { crossModule = true } },
            },
         },
      },
   })
end

return M
