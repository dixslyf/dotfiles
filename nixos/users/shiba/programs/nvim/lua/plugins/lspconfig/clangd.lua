local function setup(on_attach, capabilities)
   capabilities.offsetEncoding = { "utf-16" }

   local lspconfig = require("lspconfig")
   lspconfig.clangd.setup({
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return { setup = setup }
