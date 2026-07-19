local M = {}

function M.setup(capabilities)
   vim.lsp.enable({ "vtsls", "vue_ls" })

   vim.lsp.config("vue_ls", {
      capabilities = capabilities,
   })

   local vue_plugin = {
      name = "@vue/typescript-plugin",
      location = Globals.vue_typescript_plugin_location,
      languages = { "vue" },
      configNamespace = "typescript",
   }

   vim.lsp.config("vtsls", {
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
