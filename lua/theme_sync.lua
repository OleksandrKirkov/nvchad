-- Two-way sync between NvChad's theme picker and the system theme.
--
-- NvChad's picker saves a theme by calling nvchad.utils.replace_word(old, new) on chadrc.lua.
-- chadrc.lua reads its theme from the system theme instead of a literal, so that edit would
-- do nothing. This hands the choice to theme-switch, which recolours the whole desktop and
-- reloads every running nvim (including this one).

local theme_switch = vim.fn.expand "~/.local/bin/theme-switch"

local function patch()
  local ok, utils = pcall(require, "nvchad.utils")
  if not ok or utils._theme_sync then
    return
  end

  local original = utils.replace_word
  utils._theme_sync = true

  -- Hide light themes (M.type = "light") from NvChad's picker and Telescope themes.
  local list_themes = utils.list_themes
  utils.list_themes = function()
    local base46 = vim.fn.stdpath "data" .. "/lazy/base46/lua/base46/themes/"
    local custom = vim.fn.stdpath "config" .. "/lua/themes/"
    return vim.tbl_filter(function(name)
      for _, dir in ipairs { base46, custom } do
        local file = io.open(dir .. name .. ".lua", "r")
        if file then
          local light = file:read("*a"):find('\nM%.type%s*=%s*"light"') ~= nil
          file:close()
          return not light
        end
      end
      return true
    end, list_themes())
  end

  utils.replace_word = function(old, new, filepath)
    local chadrc = vim.fn.stdpath "config" .. "/lua/chadrc.lua"
    -- Picker and Telescope pass '"name"'; base46.toggle_theme passes 'theme = "name'.
    local name = type(new) == "string" and (new:match '^"([%w_%-]+)"$' or new:match '^theme = "([%w_%-]+)$')

    if (filepath == nil or filepath == chadrc) and name and vim.fn.executable(theme_switch) == 1 then
      vim.system({ theme_switch, name }, { detach = true })
      return
    end

    return original(old, new, filepath)
  end
end

patch()
vim.api.nvim_create_autocmd("User", { pattern = "VeryLazy", once = true, callback = patch })
