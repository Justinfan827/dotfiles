return {
  -- commenting
  'numToStr/Comment.nvim',
  opts = {
    -- add any options here
  },
  config = function()
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }
  end,
}