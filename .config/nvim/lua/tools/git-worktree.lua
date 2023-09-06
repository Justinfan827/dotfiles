local Worktree = require("git-worktree")

local Job = require("plenary.job")

-- check if this is the ansa dashboard repo
local function isAnsaDashboard()
  return not (not (string.find(vim.loop.cwd(), "ansa-dashboard.git", 1, true)))
end

Worktree.on_tree_change(
  function(op, path, upstream)
    if (op == "create" and isAnsaDashboard()) then
      print("Created new worktree. Running install.")
      Job:new(
        {
          "yarn",
          "install"
        }
      ):start()
    end
  end
)
