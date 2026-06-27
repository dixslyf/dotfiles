local M = {}

local wk = require("which-key")
local tls_builtin = require("telescope.builtin")
local common = require("plugins.lspconfig.common")

local function setup_mappings()
   wk.add({ { "<leader>d", group = "Diagnostics" } })

   local function next_diag()
      vim.diagnostic.jump({ count = 1 })
   end

   local function prev_diag()
      vim.diagnostic.jump({ count = -1 })
   end

   vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { silent = true, desc = "Show diagnostics" })
   vim.keymap.set("n", "]d", next_diag, { silent = true, desc = "Next diagnostic" })
   vim.keymap.set("n", "<leader>dj", next_diag, { silent = true, desc = "Next diagnostic" })
   vim.keymap.set("n", "[d", prev_diag, { silent = true, desc = "Previous diagnostic" })
   vim.keymap.set("n", "<leader>dk", prev_diag, { silent = true, desc = "Previous diagnostic" })
   vim.keymap.set("n", "<leader>dd", tls_builtin.diagnostics, { silent = true, desc = "List diagnostics" })
end

local servers = {
   "efm",
   "nil-ls",
   "lua-ls",
   "gopls",
   "clangd",
   "rust-analyzer",
   "svelte-language-server",
   "pyrefly",
   "ruff",
   "ltex",
   "hls",
   "tinymist",
   "vscode-html-language-server",
   "vscode-json-language-server",
   "vscode-css-language-server",
   "vscode-eslint-language-server",
   "vtsls",
   "astro-ls",
   "zls",
}

local function setup_servers()
   for _, server in ipairs(servers) do
      local capabilities = common.capabilities()
      require("plugins.lspconfig." .. server).setup(common.on_attach, capabilities)
   end
end

function M.setup()
   -- Make diagnostic jump open in a float
   vim.diagnostic.config({
      jump = {
         on_jump = function(_, bufnr)
            vim.diagnostic.open_float({
               bufnr = bufnr,
               scope = "cursor",
               focus = false,
            })
         end,
      },
   })

   setup_mappings()
   setup_servers()
end

return M
