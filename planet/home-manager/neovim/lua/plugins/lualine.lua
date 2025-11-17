local M = {}

local lualine = require("lualine")

function M.setup()
   lualine.setup({
      options = {
         theme = "catppuccin",
      },
      sections = {
         lualine_a = { "mode" },
         lualine_b = { "diagnostics" },
         lualine_c = {},
         lualine_x = { "progress", "location" },
         lualine_y = { "filetype" },
         lualine_z = {
            {
               "filename",
               file_status = true,
               newfile_status = true,
               path = 1,
               shorting_target = 135,
            },
         },
      },
      winbar = {
         lualine_a = {},
         lualine_b = {},
         lualine_c = {
            {
               "navic",
               color_correction = nil,
               navic_opts = {
                  highlight = true,
               },
            },
         },
         lualine_x = {},
         lualine_y = { "diff" },
         lualine_z = { "branch" },
      },
   })
end

return M
