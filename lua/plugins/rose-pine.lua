return {
  "rose-pine/neovim",
  lazy = true,
  priority = 1000,
  name = "rose-pine",
  config = function()
    require("rose-pine").load()
  end,
}
