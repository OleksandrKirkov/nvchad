-- Tsugumori for base46: charcoal, off-white text, red accents.
-- Palette from Tsugumori (github.com/Aleph1-9012/Tsugumori, MIT).

local M = {}

M.base_30 = {
  white = "#e8e8e8",
  darker_black = "#050505",
  black = "#0a0a0a", -- nvim bg
  black2 = "#121212",
  one_bg = "#1a1814",
  one_bg2 = "#26221f",
  one_bg3 = "#2a2a2a",
  grey = "#373331",
  grey_fg = "#555049",
  grey_fg2 = "#4e4944",
  light_grey = "#756e64",
  red = "#cc1515",
  baby_pink = "#cf443c",
  pink = "#b36758",
  line = "#26221f", -- for lines like vertsplit
  green = "#a9a196",
  vibrant_green = "#c3beb6",
  nord_blue = "#8a9cb6",
  blue = "#7a8faa",
  yellow = "#c8c8c4",
  sun = "#c3beb6",
  purple = "#9e1010",
  dark_purple = "#7a0c0c",
  teal = "#909090",
  orange = "#b36758",
  cyan = "#909090",
  statusline_bg = "#121212",
  lightbg = "#26221f",
  pmenu_bg = "#cc1515",
  folder_bg = "#7a8faa",
}

M.base_16 = {
  base00 = "#0a0a0a",
  base01 = "#121212",
  base02 = "#1a1814",
  base03 = "#555049",
  base04 = "#756e64",
  base05 = "#c8c8c4",
  base06 = "#e8e8e8",
  base07 = "#e8e8e8",
  base08 = "#cc1515",
  base09 = "#b36758",
  base0A = "#c8c8c4",
  base0B = "#a9a196",
  base0C = "#909090",
  base0D = "#7a8faa",
  base0E = "#cc1515",
  base0F = "#9e1010",
}

M.type = "dark"

M = require("base46").override_theme(M, "tsugumori")

return M
