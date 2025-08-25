-- You can add your own plugins here or in other files in this directory! I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.o.wrap = false
-- views can only be fully collapsed with the global statusline (avante)
vim.opt.laststatus = 3
-- auto-session requirement for highlighting
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
-- fzf history
vim.g.fzf_history_dir = '~/.local/share/fzf-history'

-- open repo in browser
vim.g.gh_line_map = '<leader>bg'
-- blame line
vim.g.gh_line_blame_map = ',<leader>bg'

-- require my custom mappings
require 'custom.mappings'
require 'custom.plugins.webdev'
require 'custom.plugins.golang'

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
  pattern = 'gomod',
  callback = function()
    -- idk why this is needed but it is.
    vim.cmd 'TSBufEnable highlight'
  end,
  desc = 'enable treesitter highlighting for gomod files',
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

return {
  -- custom plugins i'm developping locally
  require 'custom.plugins.dev',
  -- typescript plugins
  require 'custom.plugins.webdev',
  require 'custom.plugins.golang',
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  { -- mdx support
    'davidmh/mdx.nvim',
    config = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  -- center buffers
  {
    {
      'shortcuts/no-neck-pain.nvim',
      version = '*',
      buffers = {
        scratchPad = {
          -- set to `false` to
          -- disable auto-saving
          enabled = true,
          -- set to `nil` to default
          -- to current working directory
          location = '~/Documents/',
        },
        bo = {
          filetype = 'md',
        },
      },
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup()

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = "Add current file to Harpoon's list" })
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Toggle Harpoon list' })

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { desc = 'Select Harpoon list item 1' })
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Select Harpoon list item 2' })
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { desc = 'Select Harpoon list item 3' })
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end, { desc = 'Select Harpoon list item 4' })

      -- -- Toggle previous & next buffers stored within Harpoon list
      -- vim.keymap.set('n', '<C-S-P>', function()
      --   harpoon:list():prev()
      -- end)
      -- vim.keymap.set('n', '<C-S-N>', function()
      --   harpoon:list():next()
      -- end)
      --
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opt = {
      enable_autocmd = false,
    },
  },
  {
    'ruanyl/vim-gh-line', -- link to git repo
  },
  {
    'junegunn/fzf.vim', -- fzf
    config = function()
      vim.keymap.set('n', ',/', '<cmd>Ag!<CR>', { desc = 'live grep' })
      vim.keymap.set('n', ',ag', '<cmd>Ag! <C-R><C-W><CR>', { silent = true, desc = 'Search for word under cursor' })
    end,
  },
  {
    -- Fzf for vim: fuzzy search (ESSENTIAL)
    'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end,
  },
  'tpope/vim-fugitive', -- git wrapper in vim
  {
    'folke/trouble.nvim',
    -- for default options, refer to the configuration section for custom setup.
    opts = {
      follow = false,
    },
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
    'utilyre/barbecue.nvim', -- winbar like vscode
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {},
  },
  -- oil is a file tree navigator
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
  -- {
  --   'github/copilot.vim',
  -- },
  -- {
  --   'rmagatti/auto-session',
  --   lazy = false,
  --   ---enables autocomplete for opts
  --   ---@module "auto-session"
  --   ---@type AutoSession.Config
  --   opts = {
  --     suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
  --     -- log_level = 'debug',
  --   },
  --   keys = {
  --     -- Will use Telescope if installed or a vim.ui.select picker otherwise
  --     { '<leader>ls', '<cmd>SessionSearch<CR>', desc = 'Session search' },
  --     { '<leader>ll', '<cmd>SessionSave<CR>', desc = 'Save session' },
  --     -- { '<leader>la', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
  --   },
  -- },
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
      vim.cmd.colorscheme 'gruvbox-material'
      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
  -- commenting
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
