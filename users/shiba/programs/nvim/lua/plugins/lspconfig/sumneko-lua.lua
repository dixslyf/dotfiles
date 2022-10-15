local function setup(on_attach)
    require("neodev").setup()

    local lspconfig = require("lspconfig")
    lspconfig.sumneko_lua.setup {
        on_attach = on_attach
    }
end

return setup
