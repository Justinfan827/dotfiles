require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "lsp", "indent" }
	end,
})

vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "open all folds" })
vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "close all folds" })
vim.keymap.set("n", "zK", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end, { desc = "peek fold" })

-- disable for file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "neo-tree" },
  callback = function()
    require("ufo").detach()
    vim.opt_local.foldenable = false
  end
})
