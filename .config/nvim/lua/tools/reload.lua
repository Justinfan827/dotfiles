-- Helper to print
P = function(v)
  print(vim.inspect(v))
  return v
end

-- if plenary is installed, provide a global function to reload a module
if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end
