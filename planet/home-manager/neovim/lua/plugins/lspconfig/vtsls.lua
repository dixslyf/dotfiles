local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable({ "vtsls", "vue_ls" })

   vim.lsp.config("vue_ls", {
      on_attach = on_attach,
      capabilities = capabilities,
   })

   local vue_plugin = {
      name = "@vue/typescript-plugin",
      location = Globals.vue_typescript_plugin_location,
      languages = { "vue" },
      configNamespace = "typescript",
   }

   vim.lsp.config("vtsls", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         vtsls = {
            tsserver = {
               globalPlugins = {
                  vue_plugin,
               },
            },
         },
      },
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
   })
end

return M
