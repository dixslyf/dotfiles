local M = {}

function M.setup(capabilities)
   vim.lsp.enable("rust_analyzer")
   vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
      settings = {
         ["rust-analyzer"] = {
            checkOnSave = true,
            check = {
               features = "all",
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
