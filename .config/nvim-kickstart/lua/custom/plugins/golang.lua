-- [[
--   GoLang Configuration!
--
--         ,_---~~~~~----._
--   _,,_,*^____      _____``*g*\"*,
--  / __/ /'     ^.  /      \ ^@q   f
-- [  @f | @))    |  | @))   l  0 _/
--  \`/   \~____ / __ \_____/    \
--   |           _l__l_           I
--   }          [______]           I
--   ]            | | |            |
--   ]             ~ ~             |
--   |                            |
--    |                           |
-- ]]

-- auto import go packages
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.go' },
  callback = function()
    local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(0))
    params.context = { only = { 'source.organizeImports' } }
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding(0))
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
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*.go',
  callback = function()
    -- idk why this is needed but it is.
    vim.cmd 'TSBufEnable highlight'
    -- Insert mode: Add fmt.Println() and place cursor inside parentheses
    vim.keymap.set('i', 'fpp', 'fmt.Println()<Esc>==f(a', { desc = 'Insert fmt.Println() with cursor inside parentheses' })

    -- Insert mode: Add fmt.Println("") and place cursor inside quotes
    vim.keymap.set('i', 'fpq', 'fmt.Println("")<Esc>==f"a', { desc = 'Insert fmt.Println("") with cursor inside quotes' })

    -- Visual mode: Console log selection on next line, placing selection inside parentheses
    vim.keymap.set('v', 'fpp', 'yofpp<Esc>p', { desc = 'Console log visual selection on next line' })

    -- Normal mode: Console log on next line with "LOGGING" and word under cursor
    vim.keymap.set('n', 'fpp', '"ayiwofmt.Println("LOGGING", <C-R>a)<Esc>', { desc = 'Console log word under cursor on next line' })

    -- Insert mode: Add fmt.Printf("\\n\\n\\n") and place cursor inside parentheses
    vim.keymap.set('i', 'fpn', 'fmt.Printf("\\n\\n\\n")<Esc>==f(a', { desc = 'Insert fmt.Printf("\\n\\n\\n") with cursor inside parentheses' })
  end,
  desc = 'Set key mappings for Go development',
})
return {}
