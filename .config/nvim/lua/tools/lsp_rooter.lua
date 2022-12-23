-- Configs for project-nvim. https://github.com/ahmedkhalf/project.nvim
local M = {}
M.setup = function()
  require("project_nvim").setup {
    silent_chdir = false,
    patterns = {
      ".git",
      "_darcs",
      ".hg",
      ".bzr",
      ".svn",
      "Makefile",
      "package.json",
      "init.vim",
      "config.fish",
      ".config"
    }
  }
end

return M
