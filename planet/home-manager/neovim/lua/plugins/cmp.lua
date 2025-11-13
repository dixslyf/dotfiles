local M = {}

local cmp = require("cmp")
local types = require("cmp.types")
local luasnip = require("luasnip")

function M.setup()
   cmp.setup({
      formatting = {
         format = require("lspkind").cmp_format({
            mode = "symbol_text",
         }),
      },
      snippet = {
         expand = function(args)
            luasnip.lsp_expand(args.body)
         end,
      },
      window = {
         -- completion = cmp.config.window.bordered(),
         -- documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
         ["<Tab>"] = cmp.mapping(function(fallback)
            local has_words_before = function()
               local line, col = unpack(vim.api.nvim_win_get_cursor(0))
               return col ~= 0
                  and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            if cmp.visible() then
               cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
               luasnip.expand_or_jump()
            elseif has_words_before() then
               cmp.complete()
            else
               fallback()
            end
         end, { "i", "s" }),
         ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
               cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
               luasnip.jump(-1)
            else
               fallback()
            end
         end, { "i", "s" }),
         ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
         ["<C-j>"] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
         ["<M-k>"] = cmp.mapping.scroll_docs(-4),
         ["<M-j>"] = cmp.mapping.scroll_docs(4),
         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
         ["<C-f>"] = cmp.mapping.scroll_docs(4),
         ["<C-Space>"] = cmp.mapping.complete(),
         ["<C-e>"] = cmp.mapping.abort(),
         ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
         { name = "nvim_lsp" },
         { name = "nvim_lsp_signature_help" },
         { name = "luasnip" },
         { name = "nvim_lua" },
      }, {
         { name = "treesitter" },
         { name = "buffer" },
      }),
   })

   local cmdline_mapping = cmp.mapping.preset.cmdline({
      ["<C-k>"] = {
         c = function(fallback)
            if cmp.visible() then
               cmp.select_prev_item()
            else
               fallback()
            end
         end,
      },
      ["<C-j>"] = {
         c = function(fallback)
            if cmp.visible() then
               cmp.select_next_item()
            else
               fallback()
            end
         end,
      },
   })

   cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmdline_mapping,
      sources = cmp.config.sources({
         { name = "nvim_lsp_document_symbol" },
      }, {
         { name = "buffer" },
      }),
   })

   cmp.setup.cmdline(":", {
      mapping = cmdline_mapping,
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
end

return M
