local defaults = require "nvchad.configs.lspconfig"

local on_init = defaults.on_init
local base_on_attach = defaults.on_attach
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local function on_attach(client, bufnr)
  if base_on_attach then
    base_on_attach(client, bufnr)
  end

  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
  map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
  map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
  map("n", "gr", vim.lsp.buf.references, "Find References")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

  map("n", "<leader>ra", vim.lsp.buf.code_action, "Code Action (Alt)")
  map("n", "<leader>rr", vim.lsp.buf.rename, "Rename Symbol (Alt)")
  map("n", "<leader>rf", function()
    vim.lsp.buf.format { async = true }
  end, "Format Document")
  map("n", "<leader>rh", vim.lsp.buf.hover, "Hover")
  map("n", "<leader>rs", vim.lsp.buf.signature_help, "Signature Help")
  map("n", "<leader>rd", vim.lsp.buf.definition, "Definition")
  map("n", "<leader>ri", vim.lsp.buf.implementation, "Implementation")
  map("n", "<leader>rR", vim.lsp.buf.references, "References")
  map("n", "<leader>rc", vim.lsp.codelens.run, "Run CodeLens")
  map("n", "<leader>cl", vim.lsp.codelens.run, "Run CodeLens (Alt)")
  map("n", "<leader>f", function()
    vim.lsp.buf.format { async = true }
  end, "Format Document (Alt)")

  map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")
end

local servers = {
  gopls = {
    cmd = { "gopls" },
    root_markers = { "go.work", "go.mod", ".git" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    single_file_support = true,
    settings = {
      gopls = {
        gofumpt = true,
        completeUnimported = true,
        usePlaceholders = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          unusedparams = true,
        },
        buildFlags = { "-tags=integration_database_test" },
      },
    },
  },
  dotnet = {
    cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
    filetypes = { "cs", "vb" },
    init_options = {},
    settings = {
      {
        FormattingOptions = {
          EnableEditorConfigSupport = true,
          OrganizeImports = true,
        },
        MsBuild = {
          LoadProjectONDemand = true,
        },
        RoslynExtensionsOptions = {
          EnableAnalyzersSupport = nil,
          EnableImportCompletion = nil,
          AnalyzeOpenDocumentsOnly = true,
        },
        Sdk = {
          IncludePrereleases = true,
        },
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          inlayHints = {
            functionReturnTypes = true,
            variableTypes = true,
            parameterNames = true,
          },
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  vtsls = {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {},
        },
      },
    },
  },
  eslint = {
    settings = {
      workingDirectory = { mode = "auto" },
      format = true,
      codeActionOnSave = {
        enable = false,
        mode = "all",
      },
    },
  },
  tailwindcss = {
    filetypes = {
      "html",
      "mdx",
      "css",
      "less",
      "postcss",
      "sass",
      "scss",
      "stylus",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "templ",
    },
    settings = {
      tailwindCSS = {
        classAttributes = {
          "class",
          "className",
          "ngClass",
        },
        includeLanguages = {
          typescriptreact = "html",
          javascriptreact = "html",
        },
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidConfigPath = "error",
          invalidScreen = "error",
          invalidTailwindDirective = "error",
          invalidVariant = "error",
          recommendedVariantOrder = "warning",
        },
        validate = true,
      },
    },
  },
  html = {
    filetypes = { "html", "templ" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
    },
    single_file_support = true,
  },
  cssls = {

    filetypes = { "css", "scss", "less" },
  },
  jsonls = {
    filetypes = { "json", "jsonc" },
    init_options = {
      provideFormatter = true,
    },
    single_file_support = true,
  },
  yamlls = {
    filetypes = { "yml", "yaml", "yaml.docker-compose", "yaml.gitlab" },
    single_file_support = true,
    settings = {
      redhat = { telemetry = { enabled = false } },
    },
  },
  clangd = {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    settings = {
      clangd = {
        inlayHints = {
          enabled = true,
          parameterNames = true,
          returnTypes = true,
          variableTypes = true,
        },
      },
    },
  },
  ["sql-language-server"] = {

    filetypes = { "sql", "mysql" },
  },
  dockerls = {
    filetypes = { "dockerfile" },
    single_file_support = true,
  },
  marksman = {
    filetypes = { "markdown", "markdown.mdx" },
    single_file_support = true,
  },
  taplo = {
    filetypes = { "taplo", "lsp", "stdio" },
    single_file_support = true,
  },
  -- typos_lsp = {
  --   cmd = { "typos-lsp" },
  --   cmd_env = {
  --     RUST_LOG = "error",
  --   },
  --
  --   root_markers = {
  --     ".git",
  --     "types.toml",
  --     ".types.toml",
  --     "_types.toml",
  --   },
  --
  --   filetypes = {
  --     "go",
  --     "lua",
  --     "python",
  --     "javascript",
  --     "javascriptreact",
  --     "typescript",
  --     "typescriptreact",
  --     "markdown",
  --     "html",
  --     "css",
  --   },
  --
  --   single_file_support = true,
  -- },
}

for name, opts in pairs(servers) do
  opts.on_init = on_init
  opts.on_attach = on_attach
  opts.capabilities = capabilities
  vim.lsp.config(name, opts)
end

vim.lsp.enable(vim.tbl_keys(servers))
