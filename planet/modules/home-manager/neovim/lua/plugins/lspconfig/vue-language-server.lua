local M = {}

function M.setup(on_attach, capabilities)
   -- TODO: Replace with vue_ls after the next update.
   vim.lsp.enable("volar")
   vim.lsp.config("volar", {
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
