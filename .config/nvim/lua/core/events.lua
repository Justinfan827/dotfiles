--     tips on setting options
--     lua            command      global_value       local_value ~
--vim.o           :set                set                set
--vim.bo/vim.wo   :setlocal            -                 set
--vim.go          :setglobal          set                 -

-- map is a wrapper around vim api to help set variables
-- in a more vimscript way
-- e.g. If we wanted to do:
-- >> nnoremap <Leader>w :write<CR>
-- we would need to do:
-- >>> vim.api.nvim_set_keymap('n', '<Leader>w', ':write<CR>', {noremap = true})
local map = function(key)
	-- get the extra options
	local opts = { noremap = true }
	for i, v in pairs(key) do
		if type(i) == "string" then
			opts[i] = v
		end
	end

	-- basic support for buffer-scoped keybindings
	local buffer = opts.buffer
	opts.buffer = nil

	if buffer then
		vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
	else
		vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
	end
end

-- auto format go code
-- https://github.com/neovim/nvim-lspconfig/issues/115
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

--
-- auto import go packages
--
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function()
		local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
		params.context = { only = { "source.organizeImports" } }

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end,
})

--
-- https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990
-- set spacing / indents for go projects
--
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		-- Number of spaces that a <Tab> in the file counts for.  Also see
		-- the |:retab| command, and the 'softtabstop' option.
		vim.opt_local.tabstop = 8
		-- Number of spaces that a <Tab> counts for while performing editing
		-- operations, like inserting a <Tab> or using <BS>.  It "feels" like
		-- <Tab>s are being inserted, while in fact a mix of spaces and <Tab>s is
		-- used.  This is useful to keep the 'ts' setting at its standard value
		-- of 8, while being able to edit like it is set to 'sts'.  However,
		-- commands like "x" still work on the actual characters.
		vim.opt_local.softtabstop = 8
		-- Number of spaces to use for each step of (auto)indent.  Used for
		-- |'cindent'|, |>>|, |<<|, etc.
		-- When zero the 'ts' value will be used.  Use the |shiftwidth()|
		-- function to get the effective shiftwidth value.
		vim.opt_local.shiftwidth = 8
		vim.opt.expandtab = false

		-- fmt.Print from insert mode; Puts focus inside parentheses
		map({ "i", "fpp", "fmt.Println()<Esc>==f(a" })
		map({ "i", "fpq", 'fmt.Println("")<Esc>==f"a' })
		-- Console log from visual mode on next line, puts visual selection inside parentheses
		map({ "v", "fpp", "yofpp<Esc>p" })
		-- Console log from normal mode, inserted on next line with word your on inside parentheses
		map({ "n", "fpp", '"ayiwofmt.Println("LOGGING", <C-R>a)<Esc>' })
		map({ "i", "fpn", 'fmt.Printf("\\n\\n\\n")<Esc>==f(a' })
	end,
	desc = "Set tabstop, softtabstop, shiftwidth for go development",
})

--
-- set spacing / indents for node projects
--
vim.api.nvim_create_autocmd("FileType", {
	pattern = "javascript,javascriptreact,typescript,typescriptreact,css,md",
	callback = function()
		-- Number of spaces that a <Tab> in the file counts for.  Also see
		-- the |:retab| command, and the 'softtabstop' option.
		vim.opt_local.tabstop = 2
		-- Number of spaces that a <Tab> counts for while performing editing
		-- operations, like inserting a <Tab> or using <BS>.  It "feels" like
		-- <Tab>s are being inserted, while in fact a mix of spaces and <Tab>s is
		-- used.  This is useful to keep the 'ts' setting at its standard value
		-- of 8, while being able to edit like it is set to 'sts'.  However,
		-- commands like "x" still work on the actual characters.
		vim.opt_local.softtabstop = 2
		-- Number of spaces to use for each step of (auto)indent.  Used for
		-- |'cindent'|, |>>|, |<<|, etc.
		-- When zero the 'ts' value will be used.  Use the |shiftwidth()|
		-- function to get the effective shiftwidth value.
		vim.opt_local.shiftwidth = 2
		vim.opt.expandtab = true

		-- JSON.stringify from insert mode; Puts focus inside parentheses
		map({ "i", "clj", "console.log(JSON.stringify(,null, 2))<Esc>==f,i" })
		-- JSON.stringify from visual mode on next line, puts visual selection inside parentheses
		map({ "v", "clj", "yocll<Esc>p" })
		-- JSON.stringify from normal mode, inserted on next line with word your on inside parentheses
		map({ "n", "clj", "yiwoclj<Esc>p" })

		-- Console log from insert mode; Puts focus inside parentheses
		map({ "i", "cll", "console.log({});<Esc>==f{a" })
		-- Console log from visual mode on next line, puts visual selection inside parentheses
		map({ "v", "cll", "\"ayoconsole.log('<C-R>a:', <C-R>a);<Esc>" })
		-- Console log from normal mode, inserted on next line with word your on inside parentheses
		map({ "n", "cl'", "\"ayiwoconsole.log('<C-R>a:', <C-R>a);<Esc>" })
		map({ "n", "cll", '"ayiwoconsole.log({<C-R>a});<Esc>' })
		-- add new line in insert and normal mode
		map({ "i", "cln", "console.log('\\n\\n\\n');<Esc>" })
	end,
	desc = "Set tabstop, softtabstop, shiftwidth for node development",
})

vim.cmd([[
	augroup highlight_yank
	autocmd!
	au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
	augroup END
]])
--vim.api.nvim_create_autocmd(
--"TextYankPost",
--{
--pattern = "*",
--callback = function()
--vim.highlight.on_yank({on_visual = true})
--end
--}
--)

--auto format certain files (using formatter plugin)
-- vim.api.nvim_exec(
--   [[
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePost *.tf,*.lua,*.ts FormatWrite
-- augroup END
-- ]],
--   true
-- )

-- Showing the Inline Diagnostics Automatically in the Hover Window
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])

-- https://github.com/neovim/neovim/issues/21771
vim.cmd([[
	autocmd DirChanged * call chansend(v:stderr, printf("\033]7;file://%s\033\\", v:event.cwd))
]])

local vim = vim
local api = vim.api
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command("augroup " .. group_name)
		api.nvim_command("autocmd!")
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			api.nvim_command(command)
		end
		api.nvim_command("augroup END")
	end
end
