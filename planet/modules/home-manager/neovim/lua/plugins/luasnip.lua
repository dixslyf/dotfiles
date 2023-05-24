local M = {}

function M.setup()
   require("luasnip.loaders.from_snipmate").lazy_load()
end

return M
