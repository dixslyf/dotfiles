local function setup(on_attach, capabilities)
   -- Disable formatting capabilities to prevent conflict with null-ls alejandra
   capabilities.documentFormattingProvider = false

   require("lspconfig").rnix.setup({
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return setup
