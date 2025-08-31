--[[
--  This is my typescript / web development plugins / configurations.
--
-- ████████
--    ██
--    ██
--    ██
--    ██
--]]

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'javascript,javascriptreact,typescript,typescriptreact',
  callback = function()
    -- JSON.stringify from insert mode; Puts focus inside parentheses
    vim.keymap.set('i', 'clj', 'console.log(JSON.stringify(,null, 2))<Esc>==f,i')
    -- JSON.stringify from visual mode on next line, puts visual selection inside parentheses
    vim.keymap.set('v', 'clj', 'yocll<Esc>p')
    -- JSON.stringify from normal mode, inserted on next line with word under cursor inside parentheses
    vim.keymap.set('n', 'clj', 'yiwoclj<Esc>p')
    -- Console log from insert mode; Puts focus inside parentheses
    vim.keymap.set('i', 'cll', 'console.log({});<Esc>==f{a')
    vim.keymap.set('i', 'clt', 'console.log();<Esc>==f(a')
    -- Console log from visual mode on next line, puts visual selection inside parentheses
    vim.keymap.set('v', 'cll', "\"ayoconsole.log('<C-R>a:', <C-R>a);<Esc>")
    -- Console log from normal mode, inserted on next line with word under cursor inside parentheses
    vim.keymap.set('n', "cl'", "\"ayiwoconsole.log('<C-R>a:', <C-R>a);<Esc>")
    vim.keymap.set('n', 'cll', '"ayiwoconsole.log({<C-R>a});<Esc>')
    -- Add new line in insert and normal mode
    vim.keymap.set('i', 'cln', "console.log('\\n\\n\\n');<Esc>")
  end,
  desc = 'Set key mappings for Node development',
})

--
-- https://phelipetls.github.io/posts/mdx-syntax-highlight-treesitter-nvim/
-- support mdx
--
vim.filetype.add {
  extension = {
    mdx = 'mdx',
  },
}
-- local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername
-- ft_to_parser.mdx = 'markdown'

return {
  { 'dmmulroy/ts-error-translator.nvim' },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opt = {
      enable_autocmd = false,
    },
  },
  {
    'windwp/nvim-ts-autotag',
    lazy = false,
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-ts-autotag').setup {}
    end,
  },
}
