-- Mappings.
local wk = require("which-key")
local tls_builtin = require("telescope.builtin")

vim.keymap.set(
   "n",
   "<leader>de",
   vim.diagnostic.open_float,
   { noremap = true, silent = true, desc = "Show diagnostics" }
)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous diagnostic" })
vim.keymap.set(
   "n",
   "<leader>dk",
   vim.diagnostic.goto_prev,
   { noremap = true, silent = true, desc = "Previous diagnostic" }
)
vim.keymap.set("n", "<leader>dd", tls_builtin.diagnostics, { noremap = true, silent = true, desc = "List diagnostics" })

wk.register({ ["<leader>d"] = "Diagnostics" })

-- Use an on_attach function to only map the following keys
local on_attach = function(client, bufnr)
   -- Enable completion triggered by <c-x><c-o>
   vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

   -- Mappings.
   vim.keymap.set(
      "n",
      "<leader>lgs",
      tls_builtin.lsp_document_symbols,
      { noremap = true, silent = true, buffer = bufnr, desc = "List document symbols" }
   )
   vim.keymap.set(
      "n",
      "<leader>lgS",
      tls_builtin.lsp_workspace_symbols,
      { noremap = true, silent = true, buffer = bufnr, desc = "List workspace symbols" }
   )
   vim.keymap.set(
      "n",
      "<leader>lgD",
      vim.lsp.buf.declaration,
      { noremap = true, silent = true, buffer = bufnr, desc = "Go to declaration" }
   )
   vim.keymap.set(
      "n",
      "<leader>lgd",
      tls_builtin.lsp_definitions,
      { noremap = true, silent = true, buffer = bufnr, desc = "Go to definition" }
   )
   vim.keymap.set(
      "n",
      "<leader>lh",
      vim.lsp.buf.hover,
      { noremap = true, silent = true, buffer = bufnr, desc = "Show hover information" }
   )
   vim.keymap.set(
      "n",
      "<leader>lgi",
      tls_builtin.lsp_implementations,
      { noremap = true, silent = true, buffer = bufnr, desc = "Go to implementation" }
   )
   vim.keymap.set(
      "n",
      "<leader>ls",
      vim.lsp.buf.signature_help,
      { noremap = true, silent = true, buffer = bufnr, desc = "Show signature information" }
   )
   vim.keymap.set(
      "n",
      "<leader>lwa",
      vim.lsp.buf.add_workspace_folder,
      { noremap = true, silent = true, buffer = bufnr, desc = "Add workspace folder" }
   )
   vim.keymap.set(
      "n",
      "<leader>lwr",
      vim.lsp.buf.remove_workspace_folder,
      { noremap = true, silent = true, buffer = bufnr, desc = "Remove workspace folder" }
   )
   vim.keymap.set("n", "<leader>lwl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
   end, { noremap = true, silent = true, buffer = bufnr, desc = "List workspace folders" })
   vim.keymap.set(
      "n",
      "<leader>lgt",
      tls_builtin.lsp_type_definitions,
      { noremap = true, silent = true, buffer = bufnr, desc = "Go to type definition" }
   )
   vim.keymap.set(
      "n",
      "<leader>lr",
      vim.lsp.buf.rename,
      { noremap = true, silent = true, buffer = bufnr, desc = "Rename" }
   )
   vim.keymap.set(
      "n",
      "<leader>la",
      vim.lsp.buf.code_action,
      { noremap = true, silent = true, buffer = bufnr, desc = "Code action" }
   )
   vim.keymap.set(
      "n",
      "<leader>lgr",
      tls_builtin.lsp_references,
      { noremap = true, silent = true, buffer = bufnr, desc = "List references" }
   )
   vim.keymap.set("n", "<leader>lf", function()
      vim.lsp.buf.format({ async = true })
   end, { noremap = true, silent = true, buffer = bufnr, desc = "Format" })

   wk.register({
      ["<leader>l"] = {
         name = "LSP",
         g = "Go to",
         w = "Workspaces",
      },
   })
end

-- Set up servers
require("plugins/lspconfig/null-ls")(on_attach)
require("plugins/lspconfig/rnix")(on_attach)
require("plugins/lspconfig/sumneko-lua")(on_attach)
require("plugins/lspconfig/clangd")(on_attach)
