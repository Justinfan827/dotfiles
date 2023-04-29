require "nvim-treesitter.configs".setup {
  highlight = {
    enable = true,
    disable = {}
  },
  indent = {
    enable = false,
    disable = {}
  },
  ensure_installed = {
    "tsx",
    "typescript",
    "javascript",
    "go",
    "lua",
    "gomod",
    "fish",
    "python",
    "json",
    "markdown",
    "yaml",
    "html",
    "scss"
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"}
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?"
    }
  }
}

require("nvim-ts-autotag").setup()
require "nvim-treesitter.configs".setup {
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner"
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner"
      }
    },
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@call.outer",
        ["ic"] = "@call.inner",
        ["as"] = "@statement.outer",
        ["iv"] = "@variable",
        ["av"] = "@variable"
      }
    }
  }
}
