local M = {}

local wk = require("which-key")
local tls_builtin = require("telescope.builtin")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local function setup_mappings(bufnr)
   wk.add({
      { "<leader>l", group = "LSP" },
      { "<leader>lg", group = "Go to" },
      { "<leader>lw", group = "Workspaces" },
   })

   -- Trigger completion with <c-x><c-o>
   vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

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
      vim.lsp.buf.format({
         filter = function(client)
            return client.name ~= "ts_ls"
         end,
      })
   end, { silent = true, buffer = bufnr, desc = "Format" })
end

-- nvim-navic
local function setup_navic(client, bufnr)
   local navic = require("nvim-navic")
   navic.setup({
      highlight = true, -- Required for catppuccin integration
   })

   if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
   end
end

function M.on_attach(client, bufnr)
   setup_mappings(bufnr)
   setup_navic(client, bufnr)
end

function M.capabilities()
   local capabilities = cmp_nvim_lsp.default_capabilities()

   -- ufo
   capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
   }

   return capabilities
end

return M
