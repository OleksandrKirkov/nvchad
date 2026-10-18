---@type ChadrcConfig

local M = {}

-- Theme follows the system theme (~/.local/state/theme/current/nvim, set by theme-switch).
-- Picking a theme in NvChad's picker switches the system theme too (see lua/theme_sync.lua).
local function system_theme()
  local f = io.open(vim.fn.expand "~/.local/state/theme/current/nvim", "r")
  if f then
    local name = f:read "*l"
    f:close()
    if name and name ~= "" then
      return name
    end
  end
  return "onedark"
end

M.base46 = {
  theme = system_theme(),
  -- transparency = true,

  statusline = {
    theme = "vscode_colored",
  },

  hl_override = {
    Comment = { fg = "#5f875f", italic = true },
    ["@comment"] = { fg = "#5f875f", italic = true },
    DiffChange = {
      bg = "#3e4d3e",
      fg = "none",
    },
    DiffAdd = {
      bg = "#284828",
      fg = "none",
    },
    DiffRemoved = {
      bg = "#4c2c2c",
      fg = "none",
    },
  },
}

M.disabled = {
  n = {
    ["<A-i>"] = "",
  },
  t = {
    ["<A-i>"] = "",
  },
}

return M
