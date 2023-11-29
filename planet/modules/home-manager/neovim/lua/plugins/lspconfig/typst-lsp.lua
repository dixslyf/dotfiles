local M = {}

local lspconfig = require("lspconfig")
function M.setup(on_attach, capabilities)
   -- Neovim does not recognize Typst files by default,
   -- so the filetype needs to be manually registered.
   vim.filetype.add({
      extension = {
         typ = "typst",
      },
   })

   lspconfig.typst_lsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return M
