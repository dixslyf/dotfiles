local function setup(on_attach)
   require("lspconfig").rnix.setup({
      on_attach = on_attach,
   })
end

return setup
