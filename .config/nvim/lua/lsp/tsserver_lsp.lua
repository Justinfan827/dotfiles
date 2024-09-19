local nvim_lsp = require("lspconfig")
local lsp_utils = require("lsp.nvim_lsp")
--
-- 
--
--

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

-- https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
nvim_lsp..setup({
	on_attach = function(client, bufnr)
		lsp_utils.on_attach(client, bufnr)
	end,
	capabilities = lsp_utils.capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})
