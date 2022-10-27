local function setup(on_attach)
   local lspconfig = require("lspconfig")
   lspconfig.rust_analyzer.setup({
      on_attach = on_attach,
      settings = {
         ["rust-analyzer"] = {
            checkOnSave = {
               allFeatures = true,
               overrideCommand = {
                  "cargo",
                  "clippy",
                  "--workspace",
                  "--message-format=json",
                  "--all-targets",
                  "--all-features",
               },
            },
         },
      },
   })
end

return setup
