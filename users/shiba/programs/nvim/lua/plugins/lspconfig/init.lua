-- Mappings.
local wk = require("which-key")
local tls_builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { silent = true, desc = "Show diagnostics" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { silent = true, desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { silent = true, desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>dd", tls_builtin.diagnostics, { silent = true, desc = "List diagnostics" })

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
      { silent = true, buffer = bufnr, desc = "List document symbols" }
   )
   vim.keymap.set(
      "n",
      "<leader>lgS",
      tls_builtin.lsp_dynamic_workspace_symbols,
      { silent = true, buffer = bufnr, desc = "List workspace symbols" }
   )
   vim.keymap.set(
      "n",
      "<leader>lgD",
      vim.lsp.buf.declaration,
      { silent = true, buffer = bufnr, desc = "Go to declaration" }
   )
   vim.keymap.set(
      "n",
      "<leader>lgd",
      tls_builtin.lsp_definitions,
      { silent = true, buffer = bufnr, desc = "Go to definition" }
   )
   vim.keymap.set(
      "n",
      "<leader>lh",
      vim.lsp.buf.hover,
      { silent = true, buffer = bufnr, desc = "Show hover information" }
   )
   vim.keymap.set(
      "n",
      "<leader>lgi",
      tls_builtin.lsp_implementations,
      { silent = true, buffer = bufnr, desc = "Go to implementation" }
   )
   vim.keymap.set(
      "n",
      "<leader>ls",
      vim.lsp.buf.signature_help,
      { silent = true, buffer = bufnr, desc = "Show signature information" }
   )
   vim.keymap.set(
      "n",
      "<leader>lwa",
      vim.lsp.buf.add_workspace_folder,
      { silent = true, buffer = bufnr, desc = "Add workspace folder" }
   )
   vim.keymap.set(
      "n",
      "<leader>lwr",
      vim.lsp.buf.remove_workspace_folder,
      { silent = true, buffer = bufnr, desc = "Remove workspace folder" }
   )
   vim.keymap.set("n", "<leader>lwl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
   end, { silent = true, buffer = bufnr, desc = "List workspace folders" })
   vim.keymap.set(
      "n",
      "<leader>lgt",
      tls_builtin.lsp_type_definitions,
      { silent = true, buffer = bufnr, desc = "Go to type definition" }
   )
   vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { silent = true, buffer = bufnr, desc = "Rename" })
   vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { silent = true, buffer = bufnr, desc = "Code action" })
   vim.keymap.set(
      "n",
      "<leader>lgr",
      tls_builtin.lsp_references,
      { silent = true, buffer = bufnr, desc = "List references" }
   )
   vim.keymap.set("n", "<leader>lf", function()
      vim.lsp.buf.format({ async = true })
   end, { silent = true, buffer = bufnr, desc = "Format" })

   wk.register({
      ["<leader>l"] = {
         name = "LSP",
         g = "Go to",
         w = "Workspaces",
      },
   })

   -- nvim-navic
   local navic = require("nvim-navic")
   if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
   end
end

-- Set up servers
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local servers = { "null-ls", "rnix", "lua-ls", "clangd", "rust-analyzer", "python-lsp-server", "ltex" }
for _, server in ipairs(servers) do
   local capabilities = cmp_nvim_lsp.default_capabilities()
   require("plugins/lspconfig/" .. server)(on_attach, capabilities)
end
