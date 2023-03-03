local function setup(on_attach, capabilities)
   local lspconfig = require("lspconfig")
   lspconfig.hls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return { setup = setup }
