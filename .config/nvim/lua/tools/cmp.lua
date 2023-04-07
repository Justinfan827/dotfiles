-- setups up nvim-cmp https://github.com/hrsh7th/nvim-cmp
-- Used with the LSP + LuaSnip amongst other things
local ls = require "luasnip"
local lspkind = require("lspkind")

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
    }
    -- LEARN TO NOT USE TAB for moving
  },
  sources = {
    {name = "nvim_lua"},
    {name = "luasnip"},
    {name = "copilot"},
    {name = "nvim_lsp", max_item_count = 6},
    {name = "nvim_lua"},
    {name = "path"},
    {name = "buffer", max_item_count = 6}
  },
  -- turned this off to try out lspkind
  --formatting = {
  --fields = {"kind", "abbr", "menu"},
  --format = function(entry, vim_item)
  ---- Kind icons
  --vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
  --vim_item.menu =
  --({
  --copilot = "[Copilot]",
  --luasnip = "[LuaSnip]",
  --nvim_lua = "[NVim Lua]",
  --nvim_lsp = "[LSP]",
  --buffer = "[Buffer]",
  --path = "[Path]"
  --})[entry.source.name]
  --return vim_item
  --end
  --}
  formatting = {
    format = lspkind.cmp_format(
      {
        mode = "symbol", -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function(entry, vim_item)
          return vim_item
        end
      }
    )
  }
}
