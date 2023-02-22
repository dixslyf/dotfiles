local function setup(on_attach, capabilities)
   local lspconfig = require("lspconfig")
   lspconfig.pylsp.setup({
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

return { setup = setup }
