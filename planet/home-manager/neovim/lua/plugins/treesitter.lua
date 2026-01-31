local M = {}

local nvim_treesitter_parsers = require("nvim-treesitter.parsers")

local function get_languages()
   local parser_files = vim.api.nvim_get_runtime_file("parser/*", true)

   local installed_languages = {}
   for _, path in ipairs(parser_files) do
      -- Match the filename between the last slash and the dot (e.g., 'lua')
      local lang = path:match("([^/]+)%.%w+$")
      if lang then
         table.insert(installed_languages, lang)
      end
   end

   return installed_languages
end

function M.setup()
   local languages = get_languages()
   vim.api.nvim_create_autocmd("FileType", {
      pattern = languages,
      callback = function()
         vim.treesitter.start()
         vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
         vim.wo[0][0].foldmethod = "expr"
      end,
   })

   -- Add grammar for Typst.
   nvim_treesitter_parsers.typst = {
      install_info = {
         url = "https://github.com/uben0/tree-sitter-typst/",
         revision = "46cf4ded12ee974a70bf8457263b67ad7ee0379d",
      },
      tier = 2,
   }
   vim.treesitter.language.register("typst", "typst")
end

return M
