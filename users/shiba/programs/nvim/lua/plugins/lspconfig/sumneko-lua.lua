local function setup(on_attach)
    require("neodev").setup()

    local lspconfig = require("lspconfig")
    lspconfig.sumneko_lua.setup {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- Disable formatting capabilities to prevent conflict with null-ls stylua
            client.server_capabilities.documentFormattingProvider = false
        end
    }
end

return setup
