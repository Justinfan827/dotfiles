return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {}, tag = 'v1.11.0' },
    {
      'williamboman/mason-lspconfig.nvim',
      tag = 'v1.32.0',
    },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local function styled_diagnostic_goto(direction) -- Custom diagnostic navigation with styled floating windows
          return function() -- Navigate to next/previous diagnostic
            if direction == 'next' then
              vim.diagnostic.jump { count = 1 }
            else
              vim.diagnostic.jump { count = -1 }
            end

            local _, winid = vim.diagnostic.open_float {
              scope = 'cursor',
              source = true,
              focusable = false,
              border = 'rounded',
              close_events = {
                'CursorMoved',
                'CursorMovedI',
                'BufHidden',
                'InsertCharPre',
                'WinLeave',
              },
            }
            if winid then -- Apply the same styling as CursorHold autocommand
              vim.api.nvim_win_set_config(winid, {
                border = 'rounded',
                style = 'minimal',
              })
              vim.api.nvim_set_option_value('winhighlight', 'NormalFloat:TransparentNormal,FloatBorder:TransparentBorder', { win = winid })
            end
          end
        end

        map(']d', styled_diagnostic_goto 'next', 'Styled Next diagnostic')
        map('[d', styled_diagnostic_goto 'prev', 'Styled Previous diagnostic')

        vim.api.nvim_create_autocmd({ 'CursorHold' }, {
          pattern = '*',
          callback = function()
            for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
              if vim.api.nvim_win_get_config(winid).zindex then
                return
              end
            end
            -- Open diagnostic float and capture window ID
            local _, winid = vim.diagnostic.open_float {
              scope = 'cursor',
              source = true,
              focusable = false,
              border = 'rounded',
              close_events = {
                'CursorMoved',
                'CursorMovedI',
                'BufHidden',
                'InsertCharPre',
                'WinLeave',
              },
            }

            if winid then -- override window styles to get transparent effect
              vim.api.nvim_win_set_config(winid, {
                border = 'rounded',
                style = 'minimal',
              })
              vim.api.nvim_set_option_value('winhighlight', 'NormalFloat:TransparentNormal,FloatBorder:TransparentBorder', { win = winid })
            end
          end,
        })

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('gd', require('telescope.builtin').lsp_definitions, 'Telescope [G]oto [D]efinition')
        -- Find references for the word under your cursor.
        -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        -- Alternative (use trouble)
        -- jump to next and previous item
        local function troubleJump(direction, mode)
          local trouble = require 'trouble'
          if trouble.is_open(mode) then
            if direction == 'next' then
              ---@diagnostic disable-next-line: missing-parameter
              trouble.next { jump = true }
            else
              ---@diagnostic disable-next-line: missing-parameter
              trouble.prev { jump = true }
            end
          else
            vim.notify('Trouble is not open', vim.log.levels.INFO)
          end
        end

        -- Trouble keymaps to jump to the next/previous references
        map(']r', function()
          troubleJump('next', 'lsp_references')
        end, 'Next [r]eference')
        map('[r', function()
          troubleJump('prev', 'lsp_references')
        end, 'Previous [r]eference')

        map('gr', '<cmd>Trouble lsp_references toggle auto_refresh=false auto_jump=true<CR>', '[G]oto [R]eferences (trouble.nvim)')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        -- map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('gi', '<cmd>Trouble lsp_implementations toggle<CR>', '[G]oto [i]mplementation (Trouble.nvim)')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('gt', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end

        -- When the client is Biome, add an automatic event on
        -- save that runs Biome's "source.fixAll.biome" code action.
        -- This takes care of things like JSX props sorting and
        -- removing unused imports.
        if client and client.name == 'biome' then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('BiomeFixAll', { clear = true }),
            callback = function()
              vim.lsp.buf.format {
                filter = function(c)
                  return c.name == 'biome'
                end,
              }
              vim.lsp.buf.code_action {
                context = {
                  only = { 'source.fixAll.biome' },
                  diagnostics = {},
                },
                apply = true,
              }
            end,
          })
        end
      end,
    })

    vim.diagnostic.config {
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
    }

    -- -- LSP servers and clients are able to communicate to each other what features they support.
    -- --  By default, Neovim doesn't support everything that is in the LSP specification.
    -- --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    -- --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- clangd = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- But for many setups, the LSP (`ts_ls`) will work just fine
      biome = {},
      tailwindcss = {},
      ts_ls = {
        root_dir = require('lspconfig').util.root_pattern { 'package.json', 'tsconfig.json' },
        single_file_support = false,
      },
      denols = {
        root_dir = require('lspconfig').util.root_pattern { 'deno.json', 'deno.jsonc' },
        single_file_support = false,
      },
      gopls = {
        settings = {
          gopls = {
            buildFlags = { '-tags=integration,tools' },
          },
        },
      },
      pylsp = {
        settings = {

          pylsp = {
            plugins = {
              pycodestyle = {
                ignore = { 'W391' },
                maxLineLength = 100,
              },
              autopep8 = {
                enabled = false,
              },
              yapf = {
                enabled = false, -- let conform do the formatting
              },
            },
          },
        },
      },
      lua_ls = {
        -- cmd = { ... },
        -- filetypes = { ... },
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    --
    -- To check the current status of installed tools and/or manually install
    -- other tools, you can run
    --    :Mason
    --
    -- You can press `g?` for help in this menu.
    --
    -- `mason` had to be setup earlier: to configure its options see the
    -- `dependencies` table for `nvim-lspconfig` above.
    --
    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
