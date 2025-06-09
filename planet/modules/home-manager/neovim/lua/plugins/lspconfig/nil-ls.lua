local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("nil_ls")
   vim.lsp.config("nil_ls", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         ["nil"] = {
            formatting = {
               command = { "nixfmt" },
            },
         },
      },
   })
end

return M
