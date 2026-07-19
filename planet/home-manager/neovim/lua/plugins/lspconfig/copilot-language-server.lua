local M = {}

function M.setup(capabilities)
   vim.lsp.enable("copilot")
   vim.lsp.config("copilot", {
      capabilities = capabilities,
      settings = {
         telemetry = {
            telemtryLevel = "off",
         },
      },
   })
end

return M
