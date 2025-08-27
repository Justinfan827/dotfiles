return {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()
    -- Gruvbox Material configuration options
    vim.g.gruvbox_material_background = 'medium' -- 'hard', 'medium', 'soft'
    vim.g.gruvbox_material_foreground = 'material' -- 'material', 'mix', 'original'
    vim.g.gruvbox_material_transparent_background = 2
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_enable_italic = 1
    -- vim.g.gruvbox_material_disable_italic_comment = 1 -- uncomment to disable italic comments

    vim.cmd.colorscheme 'gruvbox-material'

    -- Get the current Normal group colors
    local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })

    -- Create transparent version with same foreground
    vim.api.nvim_set_hl(0, 'TransparentNormal', {
      fg = normal_hl.fg, -- Keep gruvbox text color
      bg = 'NONE', -- Remove background
      ctermbg = 'NONE', -- Terminal transparent background
      ctermfg = normal_hl.fg,
    })

    vim.api.nvim_set_hl(0, 'TransparentBorder', {
      fg = normal_hl.fg, -- Keep gruvbox text color
      bg = 'NONE', -- Remove background
      ctermbg = 'NONE', -- Terminal transparent background
      ctermfg = normal_hl.fg,
    })

    -- :highlight or :hi - Show all current highlight groups
    -- :hi GroupName - Show specific highlight group
    -- :Telescope highlights - Browse highlights with Telescope (if available)
    -- :so $VIMRUNTIME/syntax/hitest.vim - Show all highlight groups in action
  end,
}
