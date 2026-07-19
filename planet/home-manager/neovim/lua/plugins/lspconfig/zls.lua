local M = {}

function M.setup(capabilities)
   vim.lsp.enable("zls")
   vim.lsp.config("zls", {
      capabilities = capabilities,
      settings = {
         zls = {
            enable_build_on_save = true,
            build_on_save_step = "check",
         },
      },
   })
end

return M
