-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
--
-- LSP settings
local nvim_lsp = require "lspconfig"
-- Disable Diagnostcs globally

--LSP status for lualine
local lsp_status = require("lsp-status")
lsp_status.register_progress()

local on_attach = function(client, bufnr)
  -- add lsp-status capabilities
  lsp_status.on_attach(client)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = {noremap = true, silent = true}
  -- open diagnostics in a float
  vim.api.nvim_set_keymap("n", "<space>l", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>so",
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
    opts
  )

  -- Note: i also have the formatter plugin at the moment
  -- Format command to run lsp based formatting
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- use cmp_nvim_lsp + lsp-status capabilities
capabilities =
  vim.tbl_extend("keep", require("cmp_nvim_lsp").update_capabilities(capabilities), lsp_status.capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- folding support
--capabilities.textDocument.foldingRange = {
--dynamicRegistration = false,
--lineFoldingOnly = true
--}

--
-- LUA server
-- remember to add: export PATH="$HOME/tools/lua-language-server/bin/macOS:$PATH"
--
local sumneko_root_path = vim.fn.getenv "HOME" .. "/tools/lua-language-server" -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false
      }
    }
  }
}

--
-- eslint
--
nvim_lsp.eslint.setup {}

--
-- bashls
--
nvim_lsp.bashls.setup {}

--
-- tsserver
--
--
-- helper for nvim_buf_set_keymap
local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    mode,
    lhs,
    rhs,
    opts or
      {
        silent = true
      }
  )
end

-- https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    -- dont use lsp ts utils for now
    --local ts_utils = require("nvim-lsp-ts-utils")

    ---- set up nvim-lsp-ts-utils with some sensible defaults.
    ---- Feel free to check out the project’s repository if you want to set up additional features,
    ---- but for now, we’ll get some useful commands, diagnostics and code actions from ESLint,
    ---- and formatting from Prettier.

    --ts_utils.setup(
    --{
    ---- eslint_d, a faster version of eslint that provides a much better experience
    --eslint_bin = "eslint_d",
    --eslint_enable_diagnostics = true,
    --eslint_enable_code_actions = true,
    --enable_formatting = true,
    --formatter = "prettier",
    --format_on_save = true
    --}
    --)
    --ts_utils.setup_client(client)
    --buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
    --buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
    --buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
  end,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150
  }
}

--
-- yaml
--
nvim_lsp.yamlls.setup {}

--
-- pyright

nvim_lsp.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

--
-- gopls: https://www.getman.io/posts/programming-go-in-neovim/
--
nvim_lsp.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150
  },
  filetypes = {"go", "gomod"},
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      --env = {
      --GO_ROOT = "/Users/justin/sdk/go1.18beta1",
      --GO_ROOT = "/usr/local/opt/go/libexec",
      --PATH = "$HOME/golang/bin/go1.18beta1:$PATH"
      --},
      analyses = {
        unusedparams = true
      },
      staticcheck = true,
      buildFlags = {
        "-tags=integration"
      }
    }
  }
}

--
-- nvim-cmp setup
--

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

-- setup luasnip with nvim-cmp
local ls = require "luasnip"
-- tell luasnip where to load snippets
--require("luasnips.loaders.from_lua").load({paths = "~/.config/nvim/snippets/"})

ls.config.set_config(
  {
    history = true, -- keep around last snippet local to jump back
    updateevents = "TextChanged, TextChangedI", -- update changes as you type (function nodes + dynamic loads change as you type)
    enable_autosnippets = true,
    ext_opts = {
      -- for when you cycle through choice nodes, virtual text to indicate you're in choice node
      [require("luasnip.util.types").choiceNode] = {
        active = {
          virt_text = {{"●", "GruvboxOrange"}}
        }
      }
    }
  }
)

-- key maps

-- the expand key
vim.keymap.set(
  {"i", "s"},
  "<a-p",
  function()
    if ls.expand_or_jumpable() then
      ls.expand()
    end
  end
)

-- jumping
vim.keymap.set(
  {"i", "s"},
  "<a-k>",
  function()
    if ls.jumpable(1) then
      ls.jump(1)
    end
  end
)
vim.keymap.set(
  {"i", "s"},
  "<a-j>",
  function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end
)

-- cycle through choices
vim.keymap.set(
  {"i", "s"},
  "<a-l>",
  function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end
)
vim.keymap.set(
  {"i", "s"},
  "<a-h>",
  function()
    if ls.choice_active() then
      ls.change_choice(-1)
    end
  end
)

local cmp = require "cmp"
cmp.setup {
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<A-o>"] = cmp.mapping.select_prev_item(),
    ["<A-i>"] = cmp.mapping.select_next_item(),
    ["<A-u>"] = cmp.mapping.confirm({select = true}),
    --["<C-d>"] = cmp.mapping.scroll_docs(-4),
    --["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["C-e"] = cmp.mapping(
      {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close()
      }
    ),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
    ["<C-e>"] = cmp.mapping.close(),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to false to only confirm explicitly selected items
    ["<CR>"] = cmp.mapping.confirm {
      -- turning this on means cmp will replace current word when adding into buffer
      --behavior = cmp.ConfirmBehavior.Replace,
      select = true
    },
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end
  },
  sources = {
    {name = "luasnip"},
    {name = "copilot"},
    {name = "nvim_lsp", max_item_count = 6},
    {name = "nvim_lua"},
    {name = "path"},
    {name = "buffer", max_item_count = 6}
  },
  formatting = {
    fields = {"kind", "abbr", "menu"},
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu =
        ({
        copilot = "[Copilot]",
        luasnip = "LuaSnip",
        nvim_lua = "[NVim Lua]",
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]"
      })[entry.source.name]
      return vim_item
    end
  }
}

require "lspconfig".jsonls.setup {
  capabilities = capabilities
}