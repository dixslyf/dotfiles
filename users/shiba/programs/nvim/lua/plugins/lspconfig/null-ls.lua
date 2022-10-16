local nls = require("null-ls")

local function setup(on_attach)
    nls.setup {
        on_attach = on_attach,
        sources = {
            nls.builtins.formatting.stylua
        }
    }
end

return setup
