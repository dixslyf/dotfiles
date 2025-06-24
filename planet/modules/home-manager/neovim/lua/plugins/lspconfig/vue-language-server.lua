local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("vue_ls")
   vim.lsp.config("vue_ls", {
      on_attach = on_attach,
      capabilities = capabilities,
   })

   -- Enable Vue Typescript plugin in ts_ls.
   -- Adapted from: https://github.com/NixOS/nixpkgs/pull/374299#issuecomment-2612655254
   vim.lsp.config("ts_ls", {
      init_options = {
         plugins = {
            {
               name = "@vue/typescript-plugin",
               location = Globals.vue_typescript_plugin_location,
               languages = { "vue" },
            },
         },
      },
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
   })
end

return M
