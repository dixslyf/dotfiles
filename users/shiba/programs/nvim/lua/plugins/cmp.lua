local cmp = require("cmp")

cmp.setup({
   snippet = {
      expand = function(args)
         local luasnip = require("luasnip")
         luasnip.lsp_expand(args.body)
      end,
   },
   window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
   },
   mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
   }),
   sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "luasnip" },
      { name = "nvim_lua" },
   }, {
      { name = "buffer" },
   }),
})

cmp.setup.cmdline({ "/", "?" }, {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
      { name = "nvim_lsp_document_symbol" },
   }, {
      { name = "buffer" },
   }),
})

cmp.setup.cmdline(":", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
      { name = "path" },
   }, {
      { name = "cmdline" },
   }),
})

cmp.setup.filetype("tex", {
   sources = {
      { name = "latex_symbols", option = { strategy = 2 } },
      { name = "luasnip" },
   },
})

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
   sources = {
      { name = "dap" },
   },
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig")["<YOUR_LSP_SERVER>"].setup({
   capabilities = capabilities,
})
