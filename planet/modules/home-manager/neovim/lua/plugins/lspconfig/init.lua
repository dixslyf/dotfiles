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

-- Set up servers
local common = require("plugins.lspconfig.common")
local servers = {
   "null-ls",
   "nil-ls",
   "lua-ls",
   "clangd",
   "rust-analyzer",
   "python-lsp-server",
   "ltex",
   "hls",
}

for _, server in ipairs(servers) do
   local capabilities = common.capabilities()
   require("plugins.lspconfig." .. server).setup(common.on_attach, capabilities)
end
