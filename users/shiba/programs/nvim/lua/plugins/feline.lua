local catppuccin_feline = require("catppuccin.groups.integrations.feline")

require("feline").setup {
    components = catppuccin_feline.get()
}
