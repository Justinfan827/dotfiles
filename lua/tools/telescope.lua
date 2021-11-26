-- https://ustrajunior.com/posts/reloading-neovim-config-with-telescope/
-- The idea is to use Telescope to list my Lua modules, and when I click ctrl+e, 
-- it will call the Plenary function to reload the module. So this is how I did it.

local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}

local M = {}

function M.reload()
  -- Telescope will give us something like colors.lua, 
  -- so this function convert the selected entry to 
  -- the module name: colors
  local function get_module_name(s)
    local module_name;

    module_name = s:gsub("%.lua", "")
    module_name = module_name:gsub("%/", ".")
    module_name = module_name:gsub("%.init", "")

    return module_name
  end

  local prompt_title = "~ neovim modules ~"

  -- sets the path to the lua folder
  local path = "~/.config/nvim/lua"

  local opts = {
    prompt_title = prompt_title,
    cwd = path,

    attach_mappings = function(_, map)
     -- Adds a new map to ctrl+e.
      map("i", "<c-e>", function(_)
        -- these two are very self-explanatory
        local entry = require("telescope.actions.state").get_selected_entry()
        local name = get_module_name(entry.value)

        -- call the helper method to reload the module
        -- and give some feedback
        R(name)
        P(name .. " RELOADED!!!")
      end)

      return true
    end
  }

  -- call the builtin method to list files
  require('telescope.builtin').find_files(opts)
end

return M;
