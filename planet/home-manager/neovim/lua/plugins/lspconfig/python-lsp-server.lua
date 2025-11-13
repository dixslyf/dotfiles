local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("pylsp")
   vim.lsp.config("pylsp", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         pylsp = {
            plugins = {
               pycodestyle = { enabled = false },
               mccabe = { enabled = false },
               pyflakes = { enabled = false },
               flake8 = {
                  enabled = true,
                  maxLineLength = 88,
                  select = { "C", "E", "F", "W", "B", "B950" },
                  ignore = { "E203", "E501" },
               },
            },
         },
      },
   })
end

return M
