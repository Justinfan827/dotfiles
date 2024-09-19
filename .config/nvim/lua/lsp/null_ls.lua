-- local null_ls = require("null-ls")
-- local prettier = require("prettier")
-- prettier.setup {
--   bin = "prettierd",
--   filetypes = {
--     "css",
--     "scss",
--     "javascript",
--     "javascriptreact",
--     "typescript",
--     "typescriptreact"
--   }
-- }
-- ---- register any number of sources simultaneously
-- --
-- local sources = {
--   null_ls.builtins.formatting.prettierd
-- }
--
-- null_ls.setup({sources = sources})

local mason_null_ls = require("mason-null-ls")
local mason_automatic_setup = require("mason-null-ls.automatic_setup")
local null_ls = require("null-ls")

mason_null_ls.setup({
	ensure_installed = { "stylua", "prettier" },
	handlers = {
		-- mason automatically sets up anything that I haven't setup with a handler.
		-- in this case, for prettier, mason will call null_ls.builtins.formatting.prettier
		function(source_name, methods)
			-- all sources with no handler get passed here
			-- Keep original functionality of `automatic_setup = true`
			mason_automatic_setup(source_name, methods)
		end,
		-- special setup with stylua? maybe not needed here
		stylua = function()
			null_ls.register(null_ls.builtins.formatting.stylua)
		end,
		prettier = function()
			null_ls.register(null_ls.builtins.formatting.prettier)
		end,
	},
})

-- will setup any installed and configured sources above
-- null_ls.setup({
-- on_attach = function(client, bufnr)
-- 	-- auto format via null-ls (disabled for now for mharrington)
-- 	if client.supports_method("textDocument/formatting") then
-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
-- 		vim.api.nvim_create_autocmd("BufWritePre", {
-- 			group = augroup,
-- 			buffer = bufnr,
-- 			callback = function()
-- 				vim.lsp.buf.format({ bufnr = bufnr })
-- 			end,
-- 		})
-- 	end
-- end,
-- })
