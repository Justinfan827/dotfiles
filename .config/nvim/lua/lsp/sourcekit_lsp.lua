local lspconfig = require("lspconfig")
local cmpNvimLsp = require("cmp_nvim_lsp")

lspconfig.sourcekit.setup({
	on_attach = require("lsp.on_attach").on_attach,
	capabilities = cmpNvimLsp.default_capabilities(),
})
