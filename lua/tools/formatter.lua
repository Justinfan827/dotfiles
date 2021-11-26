-- https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/
-- https://github.com/mhartington/formatter.nvim/blob/master/CONFIG.md
--
--
-- if the LSP supports formattting, i have it setup so ff will format the file,
-- but if formatting is not supported, just use this
require("formatter").setup(
  {
    filetype = {
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
      }
    }
  }
)
