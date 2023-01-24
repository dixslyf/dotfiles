local nls = require("null-ls")

local function setup(on_attach, capabilities)
   nls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      sources = {
         nls.builtins.formatting.stylua,
         nls.builtins.formatting.alejandra,
         nls.builtins.diagnostics.editorconfig_checker.with({
            command = "editorconfig-checker",
         }),
      },
   })
end

return setup
