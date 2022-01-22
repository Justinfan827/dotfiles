-- currently not used! everythig is in nvim_lsp file

-- nvim-cmp setup directly from: https://github.com/hrsh7th/nvim-cmp/#recommended-configuration
local cmp = require "cmp"
cmp.setup(
  {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end
    },
    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
      ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-e>"] = cmp.mapping(
        {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close()
        }
      ),
      ["<CR>"] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources(
      {
        {name = "nvim_lsp"},
        {name = "luasnip"} -- For luasnip users.
        --{ name = 'vsnip' }, -- For vsnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
      },
      {
        {name = "buffer"}
      }
    )
  }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  "/",
  {
    sources = {
      {name = "buffer"}
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    sources = cmp.config.sources(
      {
        {name = "path"}
      },
      {
        {name = "cmdline"}
      }
    )
  }
)

--local cmp = require 'cmp'
--cmp.setup {
--snippet = {
--expand = function(args)
--require('luasnip').lsp_expand(args.body)
--end,
--},
--mapping = {
--['<C-p>'] = cmp.mapping.select_prev_item(),
--['<C-n>'] = cmp.mapping.select_next_item(),
--['<C-d>'] = cmp.mapping.scroll_docs(-4),
--['<C-f>'] = cmp.mapping.scroll_docs(4),
--['<C-Space>'] = cmp.mapping.complete(),
--['<C-e>'] = cmp.mapping.close(),
--['<CR>'] = cmp.mapping.confirm {
--behavior = cmp.ConfirmBehavior.Replace,
--select = true,
--},
--['<Tab>'] = function(fallback)
--if cmp.visible() then
--cmp.select_next_item()
--elseif luasnip.expand_or_jumpable() then
--luasnip.expand_or_jump()
--else
--fallback()
--end
--end,
--['<S-Tab>'] = function(fallback)
--if cmp.visible() then
--cmp.select_prev_item()
--elseif luasnip.jumpable(-1) then
--luasnip.jump(-1)
--else
--fallback()
--end
--end,
--},
--sources = {
--{ name = 'nvim_lsp' },
--{ name = 'luasnip' },
--},
--}
