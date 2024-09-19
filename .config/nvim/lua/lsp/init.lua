require("lsp.gopls_lsp")
require("lsp.signature")
--require("lsp.nvim_lsp")
--require("lsp.bashls_lsp")
--require("lsp.eslint_lsp")
--require("lsp.jsonls_lsp")
--require("lsp.lua_lsp")
--require("lsp.pyright_lsp")
--require("lsp._lsp")
--require("lsp.yamlls_lsp")
--require("lsp.sqlls_lsp")
--require("lsp.marksman_lsp")
--require("lsp.null_ls")
--require("lsp.css")
--require("lsp.emmet")
--require("lsp.html")

-- NOTE:
--It's important that I set up the plugins in the following order:

-- mason.nvim
-- mason-lspconfig.nvim
-- Setup servers via lspconfig

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
		"ts_ls",
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
		"terraformls",
		"cssmodules_ls",
		"emmet_language_server",
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
	["terraformls"] = function()
		lspconfig.terraformls.setup({
			on_attach = opts.on_attach,
			capabilities = opts.capabilities,
		})
	end,
	["ts_ls"] = function()
		local ts = require("typescript")
		ts.setup({
			server = opts,
		})
	end,
	["tailwindcss"] = function()
		lspconfig.tailwindcss.setup({
			settings = {
				tailwindCSS = {
					experimental = {
						classRegex = {
							{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
							{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
						},
					},
				},
			},
		})
	end,
	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
					client.config.settings = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							library = { vim.env.VIMRUNTIME },
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
							-- library = vim.api.nvim_get_runtime_file("", true)
						},
					})
					client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
				end
				return true
			end,
			on_attach = opts.on_attach,
			capabilities = opts.capabilities,
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
						-- disable an annoying pop up when lua lsp first initializes
						checkThirdParty = false,
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
	--
	-- gopls: https://www.getman.io/posts/programming-go-in-neovim/
	--
	["gopls"] = function()
		lspconfig.gopls.setup({
			capabilities = opts.capabilities,
			on_attach = opts.on_attach,
			flags = {
				debounce_text_changes = 150,
			},
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

-- setup nullls with mason
require("lsp.null_ls")
