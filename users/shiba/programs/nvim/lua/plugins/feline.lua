local catppuccin_feline = require("catppuccin.groups.integrations.feline")
local feline = require("feline")
local cp = require("catppuccin.palettes").get_palette()

feline.setup({
   components = catppuccin_feline.get(),
})

local navic = require("nvim-navic")
local winbar_components = {
   active = {
      {
         {
            provider = navic.get_location,
            enabled = navic.is_available,
            hl = {
               fg = cp.blue,
               bg = cp.base,
            },
            left_sep = "block",
         },
      },
   },
   inactive = {},
}

feline.winbar.setup({ components = winbar_components })
