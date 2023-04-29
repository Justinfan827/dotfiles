--require("luasnip.loaders.from_snipmate").load()
-- setup luasnip with nvim-cmp
local ls = require "luasnip"

-- tell luasnip where to load snippets
-- load if i wanna use snippets from the 'luasnippets directory'
require("luasnip.loaders.from_lua").load()
-- load if i wanna use pre loaded snippets in the 'snippets directory'
--require("luasnip.loaders.from_snipmate").load()

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
-- html snippets in javascript and javascriptreact
ls.snippets = {
  html = {}
}
ls.snippets.javascript = ls.snippets.html
ls.snippets.javascriptreact = ls.snippets.html
ls.snippets.typescriptreact = ls.snippets.html

-- from friendlysnippets
require("luasnip/loaders/from_vscode").load({include = {"html"}})
require("luasnip/loaders/from_vscode").lazy_load()

-- key maps

-- the expand key
vim.keymap.set(
  {"i", "s"},
  --"<a-p>",
  "<leader>sp",
  function()
    if ls.expand_or_jumpable() then
      ls.expand()
    end
  end
)

-- jumping
vim.keymap.set(
  {"i", "s"},
  --"<a-k>",
  "<leader>sk",
  function()
    if ls.jumpable(1) then
      ls.jump(1)
    end
  end
)
vim.keymap.set(
  {"i", "s"},
  --"<a-j>",
  "<leader>sj",
  function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end
)

-- cycle through choices
vim.keymap.set(
  {"i", "s"},
  --"<a-l>",
  "<leader>sl",
  function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end
)
vim.keymap.set(
  {"i", "s"},
  --"<a-h>",
  "<leader>sh",
  function()
    if ls.choice_active() then
      ls.change_choice(-1)
    end
  end
)
