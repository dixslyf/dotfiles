local luasnip = require("luasnip")
require("luasnip.loaders.from_snipmate").lazy_load()

vim.keymap.set({ "i" }, "<Tab>", function()
   if luasnip.expand_or_jumpable() then
      return "<Plug>luasnip-expand-or-jump"
   else
      return "<Tab>"
   end
end, { remap = true, silent = true, expr = true })
vim.keymap.set({ "i" }, "<S-Tab>", function()
   luasnip.jump(-1)
end, { silent = true })

vim.keymap.set({ "s" }, "<Tab>", function()
   luasnip.jump(1)
end, { silent = true })
vim.keymap.set({ "s" }, "<S-Tab>", function()
   luasnip.jump(-1)
end, { silent = true })
