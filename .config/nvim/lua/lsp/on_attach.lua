local M = {}

local function has_value(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

M.on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	-- setting up formatters
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
	-- https://github.com/neovim/nvim-lspconfig/wiki/Multiple-language-servers-FAQ#i-see-multiple-formatting-options-and-i-want-a-single-server-to-format-how-do-i-do-this

	if client.name == "ts_ls" then
		keymap(bufnr, "n", "gd", "<cmd>TypescriptGoToSourceDefinition<CR>", opts)
		keymap(bufnr, "n", "<leader>or", "<cmd>TypescriptOrganizeImports<CR>", opts)
		keymap(bufnr, "n", "<leader>rm", "<cmd>TypescriptRemoveUnused<CR>", opts)
	else
		-- keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		keymap(bufnr, "n", "gd", "<cmd>Trouble lsp_definitions toggle<CR>", opts)
	end

	keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gt", "<cmd>Trouble lsp_type_definitions toggle<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>Trouble lsp_implementations toggle<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>Trouble lsp_references toggle<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- rename
	vim.keymap.set("n", "<leader>rn", function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end, { expr = true })
	keymap(
		bufnr,
		"n",
		"gf", -- never use  for formatting https://www.reddit.com/r/neovim/comments/yturkn/comment/iw69zpx/?utm_source=reddit&utm_medium=web2x&context=3
		'<cmd>lua vim.lsp.buf.format({ async = true , filter = function(client) return client.name ~= "ts_ls" end })<CR>',
		opts
	)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	keymap(bufnr, "n", "d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>ds",
		[[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
		opts
	)
end

return M
