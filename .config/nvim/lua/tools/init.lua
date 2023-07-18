-- following options are the default

require("nvim-autopairs").setup {}

-- enable plugins with more complex configs
require("tools.truezen")
require("tools.reload")
require("tools.treesitter")
require("tools.telescope")
require("tools.formatter")
require("tools.nvim_tree")
require("tools.luasnip")
require("tools.copilot")
require("tools.renamer")
require("tools.lsp_rooter")
require("tools.cmp")
require("tools.dap_go")
require("tools.dap_ui")
require("tools.neodev")
require("tools.gitsigns")
require("tools.tabout")
require("tools.lastplace")
require("tools.commenter")
require("tools.whichkey")
require("tools.increname")
require("better_escape").setup(
  {
    mapping = {"kj"}
  }
)
