local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

-- Start Refactoring --

local myFirstSnippet =
  s(
  "myFirstSnippet",
  {
    t("HI THERE"),
    i(1, "WOWWWWW"),
    t("THis is another text node")
  }
)

table.insert(snippets, myFirstSnippet)

local mySecondSnippet =
  s(
  "MySecondSnippet",
  fmt(
    [[
local {} = function ({})
	{} {{ im in a curly brace}}
end
]],
    {
      i(1, ""),
      -- choice nodes cana take any type of nodes and you can cycle through these choices
      c(2, {t("wowza")}),
      i(3, "")
    }
  )
)

table.insert(snippets, mySecondSnippet)

-- regexes in lua https://riptutorial.com/lua/example/20315/lua-pattern-matching

-- End Refactoring --

return snippets, autosnippets
