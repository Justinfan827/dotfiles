return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
    },
    views = {
      notify = {
        replace = true,
        merge = true,
      },
      -- hover = {
      --   border = {
      --     style = 'rounded',
      --   },
      --   position = { row = 2, col = 2 },
      --   win_options = {
      --     winblend = 0,
      --     winhighlight = {
      --       Normal = 'TransparentNormal', -- Use our transparent group
      --       FloatBorder = 'TransparentBorder', -- Use our transparent border group
      --     },
      --   },
      -- },
    },
    routes = {
      {
        filter = { event = 'msg_show', kind = 'list_cmd' },
        view = 'messages',
      },
      {
        filter = { event = 'msg_show', kind = 'lua_print' },
        view = 'messages',
      },
      {
        filter = {
          event = 'msg_show',
          kind = 'search_count',
        },
        opts = { skip = true },
      },
    },
    cmdline = {
      format = {
        search_down = {
          view = 'cmdline',
        },
        search_up = {
          view = 'cmdline',
        },
      },
    },
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    -- 'rcarriga/nvim-notify',
  },
}
