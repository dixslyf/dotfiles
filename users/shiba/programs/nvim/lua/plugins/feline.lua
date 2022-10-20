local catppuccin_feline = require("catppuccin.groups.integrations.feline")
local feline = require("feline")

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
         },
      },
   },
   inactive = {},
}

feline.winbar.setup({ components = winbar_components })
