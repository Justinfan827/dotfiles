local whichKey = require("which-key")

local setup = {
  window = {
    border = "rounded",
    position = "bottom",
    margin = {1, 0, 1, 0},
    padding = {2, 2, 2, 2},
    winblend = 0
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "},
  show_help = true
}

local opts = {
  mode = "n",
  prefix = "<leader>",
  silent = true,
  noremap = true
}

local mappings = {
  -- ["w"] = {"<cmd>w<cr>", "Save"},
  -- ["q"] = {"<cmd>q<cr>", "Quit"},
  -- ["e"] = {"<cmd>Neotree toggle<cr>", "Toggle Explorer"},
  -- ["n"] = {"<cmd>nohl<cr>", "No highlight"},
  -- ["b"] = {
  --   name = "Buffers",
  --   ["p"] = {"<cmd>BufferLinePick<cr>", "Pick"},
  --   ["f"] = {"<cmd>BufferLineTogglePin<cr>", "Toggle pin"},
  --   ["c"] = {"<cmd>BufferLinePickClose<cr>", "Pick close"},
  --   ["d"] = {"<cmd>Bdelete<cr>", "Close Current"},
  --   ["m"] = {"<cmd>BufferLineCloseRight<cr><cmd>BufferLineCloseLeft<cr>", "Close all other"},
  --   ["l"] = {"<cmd>BufferLineCloseRight<cr>", "Close right"},
  --   ["h"] = {"<cmd>BufferLineCloseLeft<cr>", "Close left"},
  --   ["s"] = {
  --     name = "Sort",
  --     ["t"] = {"<cmd>BufferLineSortByTabs<cr>", "By tabs"},
  --     ["d"] = {"<cmd>BufferLineSortByDirectory<cr>", "By directory"},
  --     ["e"] = {"<cmd>BufferLineSortByExtension<cr>", "By extension"},
  --     ["r"] = {"<cmd>BufferLineSortByRelativeDirectory<cr>", "By relative directory"}
  --   }
  -- },
  -- ["f"] = {
  --   name = "Find",
  --   ["f"] = {"<cmd>lua require('telescope.builtin').live_grep()<CR>", "Text"},
  --   ["s"] = {"<cmd>lua require('telescope.builtin').find_files()<CR>", "Files"},
  --   ["h"] = {"<cmd>lua require('telescope.builtin').help_tags()<CR>", "Help tags"},
  --   ["b"] = {"<cmd>lua require('telescope.builtin').buffers()<CR>", "Buffers"},
  --   ["m"] = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Marked files"}
  -- },
  -- ["g"] = {
  --   name = "Git",
  --   ["s"] = {"<cmd>lua require('telescope.builtin').git_status()<CR>", "Status"},
  --   ["c"] = {"<cmd>lua require('telescope.builtin').git_commits()<CR>", "Commits"},
  --   ["b"] = {"<cmd>lua require('telescope.builtin').git_branches()<CR>", "Branches"},
  --   ["d"] = {
  --     name = "Diff view",
  --     ["o"] = {"<cmd>DiffviewOpen<CR>", "Open"},
  --     ["d"] = {"<cmd>DiffviewClose<CR>", "Close"},
  --     ["l"] = {"<cmd>DiffviewLog<CR>", "Log"},
  --     ["r"] = {"<cmd>DiffviewRefresh<CR>", "Refresh"},
  --     ["f"] = {"<cmd>DiffviewFocusFiles<CR>", "Focus files"},
  --     ["h"] = {"<cmd>DiffviewFileHistory<CR>", "File history"}
  --   }
  -- },
  ["l"] = {
    name = "LSP",
    ["D"] = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration"},
    ["d"] = {"<cmd>lua vim.lsp.buf.definition()<cr>", "Definition"},
    ["T"] = {"<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type definition"},
    ["i"] = {"<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation"},
    ["R"] = {"<cmd>lua vim.lsp.buf.references()<cr>", "References"},
    ["K"] = {"<cmd>lua vim.lsp.buf.hover()<cr>", "Hover"},
    ["k"] = {"<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help"},
    ["s"] = {"<cmd>SymbolsOutline<cr>", "Toggle symbols outline"},
    ["n"] = {":IncRename ", "Rename"},
    ["a"] = {"<cmd>CodeActionMenu<cr>", "Code actions"},
    ["f"] = {"<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format"},
    ["l"] = {"<cmd>lua vim.diagnostic.open_float()<cr>", "Open float"},
    ["t"] = {
      name = "TypeScript",
      ["a"] = {"<cmd>TypescriptAddMissingImports<CR>", "Add missing imports"},
      ["o"] = {"<cmd>TypescriptOrganizeImports<CR>", "Organize imports"},
      ["u"] = {"<cmd>TypescriptRemoveUnused<CR>", "Remove unused"},
      ["f"] = {"<cmd>TypescriptFixAll<CR>", "Fix all"},
      ["g"] = {"<cmd>TypescriptGoToSourceDefinition<CR>", "Go to source definition"},
      ["r"] = {"<cmd>TypescriptRenameFile<CR>", "Rename file"}
    },
    ["u"] = {
      name = "Trouble",
      r = {"<cmd>TroubleToggle lsp_references<cr>", "References"},
      f = {"<cmd>TroubleToggle lsp_definitions<cr>", "Definitions"},
      d = {"<cmd>TroubleToggle document_diagnostics<cr>", "Diagnostics"},
      q = {"<cmd>TroubleToggle quickfix<cr>", "QuickFix"},
      l = {"<cmd>TroubleToggle loclist<cr>", "LocationList"},
      w = {"<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics"}
    }
  }
  -- consider turning this on
  -- ["s"] = {
  --   name = "Session",
  --   ["s"] = {"<cmd>lua require('persistence').load()<cr>", "Load current directory"},
  --   ["l"] = {"<cmd>lua require('persistence').load({ last = true })<cr>", "Load last session"},
  --   ["d"] = {"<cmd>lua require('persistence').stop()<cr>", "Stop session"}
  -- }
}

whichKey.setup(setup)
whichKey.register(mappings, opts)
