return {
  "hrsh7th/nvim-cmp",
  dependencies = { 
    "hrsh7th/cmp-nvim-lsp", 
    "hrsh7th/cmp-buffer", 
    "hrsh7th/cmp-path", 
    "onsails/lspkind-nvim" 
  },
  config = function()
    local cmp = require "cmp"
    local lspkind = require "lspkind"
    cmp.setup {
      mapping = {
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
      },
      sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" }
      },
      formatting = {
        format = lspkind.cmp_format {
          mode = "symbol_text",
          maxwidth = 50,
        },
      },
    }
  end,
}
