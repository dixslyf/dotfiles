local M = {}

local lspconfig = require("lspconfig")
function M.setup(on_attach, capabilities)
   lspconfig.eslint.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         -- The server can automatically fix problems by "formatting".
         -- I don't want this, and this will probably conflict with Prettier anyway.
         format = false,

         -- Required, otherwise the language server will not be able to find the ESLint library
         nodePath = Globals.vscode_eslint_language_server_node_path,
      },
   })
end

return M
