local function setup(on_attach, capabilities)
   local lspconfig = require("lspconfig")
   lspconfig.ltex.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         ltex = {
            language = "en-GB",
         },
      },
   })
end

return { setup = setup }
