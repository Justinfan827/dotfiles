-- lualine
local status, lualine = pcall(require, "lualine")

local function getLsp()
  local msg = "No Active Lsp"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

if (not status) then
  return
end
lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    --theme = "solarized_dark",
    theme = "gruvbox-material",
    component_separators = {left = "", right = ""},
    section_separators = {left = "", right = ""},
    disabled_filetypes = {"neo-tree-popup", "alpha", "NvimTree"}
    -- section_separators = {"", ""},
    -- component_separators = {"", ""},
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff"},
    lualine_c = {
      {"filename", path = 1}
    },
    lualine_x = {"diagnostics", getLsp, "encoding", "fileformat", "filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
    -- lualine_x = {
    --   {"diagnostics", sources = {"nvim_lsp"}, symbols = {error = " ", warn = " ", info = " ", hint = " "}},
    --   "encoding",
    --   "filetype"
    -- },
    -- lualine_y = {
    --   function()
    --     return require("lsp-status").status()
    --   end
    -- },
    -- lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {"fugitive"}
}
