local M = {}

function M.setup(on_attach, capabilities)
   vim.lsp.enable("groovyls")
   vim.lsp.config("groovyls", {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "groovy-language-server" },
   })
end

return M
