local M = {}

function M.setup(capabilities)
   vim.lsp.enable("nil_ls")
   vim.lsp.config("nil_ls", {
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
