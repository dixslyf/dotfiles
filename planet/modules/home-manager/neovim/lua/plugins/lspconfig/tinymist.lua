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

   lspconfig.tinymist.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         formatterMode = "typstyle",
      },
   })
end

return M
