local M = {}

function M.setup(capabilities)
   vim.lsp.enable("hls")
   vim.lsp.config("hls", {
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
