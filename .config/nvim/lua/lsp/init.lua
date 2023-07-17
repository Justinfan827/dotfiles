require("lsp.gopls_lsp")
--require("lsp.nvim_lsp")
--require("lsp.bashls_lsp")
--require("lsp.eslint_lsp")
--require("lsp.jsonls_lsp")
--require("lsp.lua_lsp")
--require("lsp.pyright_lsp")
--require("lsp.tsserver_lsp")
--require("lsp.yamlls_lsp")
--require("lsp.sqlls_lsp")
--require("lsp.marksman_lsp")
--require("lsp.null_ls")
--require("lsp.css")
--require("lsp.tailwindcss")
--require("lsp.emmet")
--require("lsp.html")

-- comment out the above and uncomment the below to try out mason.
-- trying out mason.

local mason = require("mason")
local lspconfig = require("lspconfig")
local masonLspConfig = require("mason-lspconfig")
local cmpNvimLsp = require("cmp_nvim_lsp")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

masonLspConfig.setup({
	ensure_installed = {
		"lua_ls",
		"jsonls",
		"tsserver",
		"eslint",
		"prismals",
		"gopls",
		"tailwindcss",
		"html",
		"cssls",
		"astro",
		"yamlls",
		"taplo",
		"marksman",
		"dockerls",
		"cssmodules_ls",
	},
})

local opts = {
	capabilities = cmpNvimLsp.default_capabilities(),
	on_attach = require("lsp.on_attach").on_attach,
}

-- :h mason-lspconfig.setup_handlers()
masonLspConfig.setup_handlers({
	-- default setup function
	function(server_name)
		-- setup custom server configs
		local has_custom_opts, custom_opts = pcall(require, "config.lsp.settings." .. server_name)
		local server_opts = opts
		if has_custom_opts then
			server_opts = vim.tbl_deep_extend("force", custom_opts, opts)
		end
		lspconfig[server_name].setup(server_opts)
	end,
	["tsserver"] = function()
		local ts = require("typescript")
		ts.setup({
			server = opts,
		})
	end,
	--
	-- gopls: https://www.getman.io/posts/programming-go-in-neovim/
	--
	["gopls"] = function()
		lspconfig.gopls.setup({
			capabilities = cmpNvimLsp.default_capabilities(),
			on_attach = require("lsp.on_attach").on_attach,
			flags = {
				debounce_text_changes = 150,
			},
			--root_dir = nvim_lsp.util.root_pattern("main.go", "go.mod"),
			filetypes = { "go", "gomod" },
			cmd = { "gopls", "serve" },
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					buildFlags = {
						"-tags=integration",
					},
				},
			},
		})
	end,
})

require("lsp.null_ls")
