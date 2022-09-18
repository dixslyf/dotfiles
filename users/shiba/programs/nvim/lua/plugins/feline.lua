local catppuccin_feline = require("catppuccin.groups.integrations.feline")
local feline = require("feline")

feline.setup {
    components = catppuccin_feline.get()
}

feline.winbar.setup()
