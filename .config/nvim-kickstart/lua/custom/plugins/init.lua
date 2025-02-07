-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.o.wrap = false
-- auto-session requirement for highlighting
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
-- open repo in browser
vim.g.gh_line_map = '<leader>bg'

-- fzf history
vim.g.fzf_history_dir = '~/.local/share/fzf-history'

vim.keymap.set('n', ';', ':', { desc = 'Remap : to ;' })
vim.keymap.set('n', '<CR>', 'G', { desc = 'Jump to line number with 123<CR>' })
vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Move to the start of the line' })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { desc = 'Move to the end of the line' })
vim.keymap.set('i', 'kj', '<ESC>', { desc = 'Exit insert mode' })
vim.keymap.set('n', ',w', '<cmd>w<cr>', { desc = 'Write to buffer' })
vim.keymap.set('n', 'ss', ':split<Return><C-w>w', { desc = 'Horizontally split window' })
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { desc = 'Vertically split window' })
vim.keymap.set('n', '<leader>vv', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Change word under cursor' })
vim.keymap.set('n', ',,', ':noh<CR>', { desc = 'Clearing out highlights' })
vim.keymap.set('n', 's*', ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn")
vim.keymap.set('x', 's*', 'sy:let @/=@s<CR>cgn')
vim.keymap.set('n', '<C-s>', "<cmd>lua require('treesj').toggle()<CR>", { silent = true })

vim.keymap.set('n', '<Leader>gd', ':Gvdiffsplit<CR>', { desc = 'Git diff' })
vim.keymap.set('n', '<Leader>gms', ':Gvdiffsplit origin/master<CR>')
vim.keymap.set('n', '<Leader>gma', ':Gvdiffsplit origin/main<CR>')
vim.keymap.set('n', '<Leader>gg', ':Git<CR>')
vim.keymap.set('n', '<Leader>gw', ':Gwrite<CR><CR>')
vim.keymap.set('n', '<Leader>gr', ':Gread<CR>')
vim.keymap.set('n', '<Leader>gb', ':Git blame<CR>')

--
-- auto import go packages
--
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
--
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
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
  desc = 'Set tabstop, softtabstop, shiftwidth for go development',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'javascript,javascriptreact,typescript,typescriptreact,css,md',
  callback = function()
    -- JSON.stringify from insert mode; Puts focus inside parentheses
    vim.keymap.set('i', 'clj', 'console.log(JSON.stringify(,null, 2))<Esc>==f,i')
    -- JSON.stringify from visual mode on next line, puts visual selection inside parentheses
    vim.keymap.set('v', 'clj', 'yocll<Esc>p')
    -- JSON.stringify from normal mode, inserted on next line with word under cursor inside parentheses
    vim.keymap.set('n', 'clj', 'yiwoclj<Esc>p')
    -- Console log from insert mode; Puts focus inside parentheses
    vim.keymap.set('i', 'cll', 'console.log({});<Esc>==f{a')
    -- Console log from visual mode on next line, puts visual selection inside parentheses
    vim.keymap.set('v', 'cll', "\"ayoconsole.log('<C-R>a:', <C-R>a);<Esc>")
    -- Console log from normal mode, inserted on next line with word under cursor inside parentheses
    vim.keymap.set('n', "cl'", "\"ayiwoconsole.log('<C-R>a:', <C-R>a);<Esc>")
    vim.keymap.set('n', 'cll', '"ayiwoconsole.log({<C-R>a});<Esc>')
    -- Add new line in insert and normal mode
    vim.keymap.set('i', 'cln', "console.log('\\n\\n\\n');<Esc>")
  end,
  desc = 'Set tabstop, softtabstop, shiftwidth for node development',
})

local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring() or get_option(filetype, option)
end
return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opt = {
      enable_autocmd = false,
    },
  },
  'ruanyl/vim-gh-line', -- link to git repo
  {

    'junegunn/fzf.vim', -- fzf
    config = function()
      vim.keymap.set('n', ',/', ':Ag!<CR>', { desc = 'live grep' })
      vim.keymap.set('n', ',ag', ':Ag! <C-R><C-W><CR>', { silent = true, desc = 'Search for word under cursor' })
    end,
  },
  {
    -- Fzf for vim: fuzzy search (ESSENTIAL)
    'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end,
  },
  -- automatically close tags e.g. in html.
  {

    'tpope/vim-fugitive', -- git wrapper in vim
    'windwp/nvim-ts-autotag',
    opts = {
      -- Defaults
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = true, -- Auto close on trailing </
    },
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },

  -- help navigate with vim / tmux splits
  'christoomey/vim-tmux-navigator',
  -- treesitter targeting of functions / paragraphs / classes
  'nvim-treesitter/nvim-treesitter-textobjects',
  -- start screen
  {
    'goolord/alpha-nvim',
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require 'alpha.themes.startify'
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = 'devicons'
      require('alpha').setup(startify.config)
    end,
  },

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    'github/copilot.vim',
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { '<leader>ls', '<cmd>SessionSearch<CR>', desc = 'Session search' },
      { '<leader>ll', '<cmd>SessionSave<CR>', desc = 'Save session' },
      -- { '<leader>la', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
    },
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require('treesj').setup {--[[ your config ]]
      }
    end,
  },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 2
      -- vim.cmd.colorscheme 'gruvbox-material'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  -- colorscheme for transparent background
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    init = function()
      -- Load the colorscheme here.
      vim.cmd.colorscheme 'catppuccin-mocha'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   opts = {
  --     transparent = true, -- Enable this to disable setting the background color
  --     styles = {
  --       -- Background styles. Can be "dark", "transparent" or "normal"
  --       sidebars = 'transparent', -- style for sidebars, see below
  --       floats = 'transparent', -- style for floating windows
  --     },
  --   },
  --   init = function()
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-night'
  --
  --     -- You can configure highlights by doing something like:
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },

  {
    'jellydn/hurl.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- Optional, for markdown rendering with render-markdown.nvim
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown' },
        },
        ft = { 'markdown' },
      },
    },
    ft = 'hurl',
    opts = {
      -- Show debugging info
      debug = false,
      -- Show notification on run
      show_notification = false,
      -- Show response in popup or split
      mode = 'split',
      -- Default formatter
      formatters = {
        json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
          'prettier', -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          '--parser',
          'html',
        },
        xml = {
          'tidy', -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
          '-xml',
          '-i',
          '-q',
        },
      },
      -- Default mappings for the response popup or split views
      mappings = {
        close = 'q', -- Close the response popup or split view
        next_panel = '<C-n>', -- Move to the next response popup window
        prev_panel = '<C-p>', -- Move to the previous response popup window
      },
    },
    keys = {
      -- Run API request
      { '<leader>A', '<cmd>HurlRunner<CR>', desc = 'Run All requests' },
      { '<leader>a', '<cmd>HurlRunnerAt<CR>', desc = 'Run Api request' },
      { '<leader>te', '<cmd>HurlRunnerToEntry<CR>', desc = 'Run Api request to entry' },
      { '<leader>tE', '<cmd>HurlRunnerToEnd<CR>', desc = 'Run Api request from current entry to end' },
      { '<leader>tm', '<cmd>HurlToggleMode<CR>', desc = 'Hurl Toggle Mode' },
      { '<leader>tv', '<cmd>HurlVerbose<CR>', desc = 'Run Api in verbose mode' },
      { '<leader>tV', '<cmd>HurlVeryVerbose<CR>', desc = 'Run Api in very verbose mode' },
      -- Run Hurl request in visual mode
      { '<leader>h', ':HurlRunner<CR>', desc = 'Hurl Runner', mode = 'v' },
    },
  },
}
