return {
  {
    dir = '~/nvim-plugins/completor.nvim',
    config = function()
      -- Lazy will automatically prepend the plugin’s path to the runtimepath,
      -- so require('completor') works as if it were a top-level module.
      require 'completor'
    end,
  },
  {
    dir = '~/nvim-plugins/alternator.nvim',
    config = function()
      -- Lazy will automatically prepend the plugin’s path to the runtimepath,
      -- so require('alternator') works as if it were a top-level module.
      require 'alternator'
    end,
  },
}
