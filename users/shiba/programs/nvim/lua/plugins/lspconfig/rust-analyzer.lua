local function setup(on_attach)
   local lspconfig = require("lspconfig")
   lspconfig.rust_analyzer.setup({
      on_attach = on_attach,
   })
end

return setup
