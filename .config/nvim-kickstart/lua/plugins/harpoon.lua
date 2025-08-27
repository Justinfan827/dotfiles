return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = "Add current file to Harpoon's list" })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Toggle Harpoon list' })

    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = 'Select Harpoon list item 1' })
    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = 'Select Harpoon list item 2' })
    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = 'Select Harpoon list item 3' })
    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = 'Select Harpoon list item 4' })

    -- -- Toggle previous & next buffers stored within Harpoon list
    -- vim.keymap.set('n', '<C-S-P>', function()
    --   harpoon:list():prev()
    -- end)
    -- vim.keymap.set('n', '<C-S-N>', function()
    --   harpoon:list():next()
    -- end)
    --
  end,
}