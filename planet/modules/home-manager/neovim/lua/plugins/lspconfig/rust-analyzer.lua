local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("rust_analyzer")
   vim.lsp.config("rust_analyzer", {
      on_attach = on_attach,
      capabilities = capabilities,
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

return M
