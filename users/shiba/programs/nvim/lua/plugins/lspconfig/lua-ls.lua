local function setup(on_attach, capabilities)
   require("neodev").setup()

   -- Disable formatting capabilities to prevent conflict with null-ls stylua
   capabilities.documentFormattingProvider = false

   require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

return setup
