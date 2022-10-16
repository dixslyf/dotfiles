local function setup(on_attach)
   require("lspconfig").rnix.setup({
      on_attach = function(client, bufnr)
         on_attach(client, bufnr)
         -- Disable formatting capabilities to prevent conflict with null-ls alejandra
         client.server_capabilities.documentFormattingProvider = false
      end,
   })
end

return setup
