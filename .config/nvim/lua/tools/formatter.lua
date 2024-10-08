-- Utilities for creating configurations
local util = require "formatter.util"
-- https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/
-- https://github.com/mhartington/formatter.nvim/blob/master/CONFIG.md
--
--
-- if the LSP supports formattting, i have it setup so ff will format the file,
-- but if formatting is not supported, just use this

require("formatter").setup(
  {
    filetype = {
      css = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
            stdin = true
          }
        end
      },
      html = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
            stdin = true
          }
        end
      },
      sh = {
        -- Shell Script Formatter
        function()
          return {
            exe = "shfmt",
            args = {"-i", 2},
            stdin = true
          }
        end
      },
      markdown = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
            stdin = true
          }
        end
      },
      yaml = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
            stdin = true
          }
        end
      },
      sql = {
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
            stdin = true
          }
        end
      },
      typescriptreact = {
        -- require("formatter.defaults.prettier")
        function()
          return {
            exe = "./node_modules/.bin/prettier",
            -- exe = "prettier", -- idk why these are different? same version
            args = {"--stdin-filepath", util.escape_path(util.get_current_buffer_file_path())},
            stdin = true
          }
        end
      },
      javascriptreact = {
        require("formatter.defaults.prettier")
        -- prettier
        -- function()
        --   return {
        --     exe = "prettier",
        --     args = {"--stdin-filepath", util.escape_path(util.get_current_buffer_file_path())},
        --     stdin = true
        --   }
        -- end
      },
      typescript = {
        -- prettier
        function()
          return {
            exe = "./node_modules/.bin/prettier",
            -- exe = "prettier", // idk why these are different? same version
            args = {"--stdin-filepath", util.escape_path(util.get_current_buffer_file_path())},
            stdin = true
          }
        end
      },
      javascript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
            stdin = true
          }
        end
      },
      terraform = {
        function()
          return {
            exe = "terraform",
            args = {"fmt", "-"},
            stdin = true
          }
        end
      },
      lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      python = {
        function()
          return {
            exe = "~/Library/Python/3.8/bin/black",
            args = {"-q", "-"},
            stdin = true
          }
        end
      },
      -- json = {
      --   function()
      --     return {
      --       exe = "./node_modules/.bin/prettier",
      --       args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--double-quote"},
      --       stdin = true
      --     }
      --   end
      -- }
    }
  }
)
