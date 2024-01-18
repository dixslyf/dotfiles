local M = {}

local lspconfig = require("lspconfig")

local efmls_configs_utils = require("efmls-configs.utils")

local stylua = require("efmls-configs.formatters.stylua")
-- FIXME: For some reason, formatting with `fnlfmt` prints 2 extra newlines at the end of the file on the first invocation.
-- On the second invocation, it is reduced to 1 extra newline.
local fnlfmt = { formatCommand = "fnlfmt -", formatStdin = true }
local prettier = require("efmls-configs.formatters.prettier")
local shfmt = { formatCommand = "shfmt --indent 2 -filename '${INPUT}' -", formatStdin = true }
local shellcheck = require("efmls-configs.linters.shellcheck")
local latexindent = { formatCommand = "latexindent -l -m -", formatStdin = true }
local proselint = require("efmls-configs.linters.proselint")
local statix = require("efmls-configs.linters.statix")
local deadnix = {
   prefix = "deadnix",
   lintSource = efmls_configs_utils.sourceText("deadnix"),
   lintCommand = [[
      DEADNIX_JSON=$(deadnix --fail --output-format=json '${INPUT}')
      if [ "$?" ]; then
         printf '%s' "$DEADNIX_JSON" | jq -r '.file as $file | .results | map("\($file):\(.column):\(.endColumn):\(.line)>\(.message)") | .[]'
         exit 1
      fi
   ]],
   lintStdin = false,
   lintFormats = { "%f:%c:%k:%l>%m" },
   lintSeverity = 2,
   rootMarkers = { "flake.nix", "shell.nix", "default.nix" },
}
local actionlint = require("efmls-configs.linters.actionlint")
local yamllint = require("efmls-configs.linters.yamllint")
local editorconfig_checker = {
   prefix = "editorconfig-checker",
   lintSource = efmls_configs_utils.sourceText("editorconfig-checker"),
   lintCommand = "editorconfig-checker -no-color '${INPUT}'",
   lintStdin = false,
   lintFormats = { "\t%l: %m", "\t%m" },
}
local google_java_format = {
   formatCommand = "google-java-format -aosp -",
   formatStdin = true,
}
local htmlhint = {
   prefix = "HTMLHint",
   lintSource = efmls_configs_utils.sourceText("HTMLHint"),
   lintCommand = "htmlhint --nocolor --format unix stdin",
   lintStdin = true,
   lintFormats = { "%f:%l:%c: %m" },
}

function M.setup(on_attach, capabilities)
   local languages = {
      lua = { stylua },
      fennel = { fnlfmt },
      -- `prettier` file types from: https://github.com/nvimtools/none-ls.nvim/blob/main/lua/null-ls/builtins/formatting/prettier.lua
      javascript = { prettier },
      javascriptreact = { prettier },
      typescript = { prettier },
      typescriptreact = { prettier },
      vue = { prettier },
      css = { prettier },
      scss = { prettier },
      less = { prettier },
      html = {
         prettier,
         htmlhint,
      },
      json = { prettier },
      jsonc = { prettier },
      yaml = {
         prettier,
         actionlint,
         yamllint,
      },
      markdown = {
         prettier,
         proselint,
      },
      ["markdown.mdx"] = { prettier },
      graphql = { prettier },
      handlebars = { prettier },
      tex = {
         latexindent,
         proselint,
      },
      sh = {
         shfmt,
         shellcheck,
      },
      nix = {
         statix,
         deadnix,
      },
      java = { google_java_format },
      -- Wildcard (https://github.com/mattn/efm-langserver/blob/95f915ad7e125a3995a86445fc76818307fa3ca8/langserver/lsp.go#L3)
      ["="] = { editorconfig_checker },
   }

   lspconfig.efm.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = vim.tbl_keys(languages),
      init_options = {
         documentFormatting = true,
         documentRangeFormatting = true,
         codeAction = true,
      },
      settings = {
         rootMarkers = { ".git/" },
         languages = languages,
      },
   })
end

return M
