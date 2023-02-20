local function setup(on_attach, capabilities)
   require("neodev").setup()

   require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         Lua = {
            format = {
               enable = false,
            },
         },
      },
   })
end

return setup
