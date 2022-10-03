-- setups up nvim-cmp https://github.com/hrsh7th/nvim-cmp
-- Used with the LSP + LuaSnip amongst other things
local ls = require "luasnip"

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
    },
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          fallback()
        end
      end,
      {"i", "s"}
    ),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif ls.jumpable(-1) then
          ls.jump(-1)
        else
          fallback()
        end
      end,
      {"i", "s"}
    )
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
        luasnip = "[LuaSnip]",
        nvim_lua = "[NVim Lua]",
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]"
      })[entry.source.name]
      return vim_item
    end
  }
}
