local ls = require("luasnip")
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

-- regexes in lua https://riptutorial.com/lua/example/20315/lua-pattern-matching

-- quickly write tables tests
local tableTest =
  s(
  "tbt",
  fmt(
    [[
func Test{}(t *testing.T) {{
	tests := []struct {{
		name string
	}}{{
		{{
			name: "{}",
		}},
	}}

	for _, test := range tests {{
		test := test
		t.Run(test.name, func(t *testing.T) {{
			t.Parallel()
			its := assert.New(t)
		}})
	}}
}}
]],
    {
      i(1, "test name"),
      i(2, "case name")
    }
  )
)
table.insert(snippets, tableTest)

local forrange =
  s(
  "forr",
  fmt(
    [[
	for _, {} := range {} {{

	}}
]],
    {
      i(1, "opt"),
      i(2, "opts")
    }
  )
)
table.insert(snippets, forrange)

-- End Refactoring --

return snippets, autosnippets
