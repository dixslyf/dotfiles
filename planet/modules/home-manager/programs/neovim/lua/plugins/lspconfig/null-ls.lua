local nls = require("null-ls")

local function setup(on_attach, capabilities)
   nls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      sources = {
         nls.builtins.formatting.stylua,
         nls.builtins.formatting.fnlfmt,
         nls.builtins.formatting.prettier,
         nls.builtins.formatting.latexindent.with({
            args = { "-l", "-m" },
         }),
         nls.builtins.formatting.shfmt.with({
            extra_args = { "--indent", "2" },
         }),
         nls.builtins.code_actions.shellcheck,
         nls.builtins.code_actions.proselint,
         nls.builtins.diagnostics.shellcheck,
         nls.builtins.diagnostics.proselint,
         nls.builtins.diagnostics.statix,
         nls.builtins.diagnostics.deadnix,
         nls.builtins.diagnostics.actionlint,
         nls.builtins.diagnostics.yamllint,
         nls.builtins.diagnostics.editorconfig_checker.with({
            command = "editorconfig-checker",
         }),
      },
   })
end

return { setup = setup }
