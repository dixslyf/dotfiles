local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("zls")
   vim.lsp.config("zls", {
      on_attach = on_attach,
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
