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
            exe = "prettierd",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
            stdin = true
          }
        end
      },
      html = {
        -- prettier
        function()
          return {
            exe = "prettierd",
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
      typescriptreact = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
            stdin = true
          }
        end
      },
      typescript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
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
      json = {
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--double-quote"},
            stdin = true
          }
        end
      }
    }
  }
)
