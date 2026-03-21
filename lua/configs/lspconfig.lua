local lsp = vim.lsp
local root = require "utils.root"
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities_default)
cmp_capabilities.offsetEncoding = { "utf-16" }

local function on_attach_extended(client, bufnr)
  if on_attach_default then
    on_attach_default(client, bufnr)
  end

  if client.server_capabilities.textDocumentSync then
    require("vim.lsp._changetracking").init(client, bufnr)
  end

  local function buf_map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  buf_map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
  buf_map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  buf_map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
  buf_map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
  buf_map("n", "gr", vim.lsp.buf.references, "Find References")
  buf_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  buf_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

  buf_map("n", "<leader>ra", vim.lsp.buf.code_action, "Code Action (Alt)")
  buf_map("n", "<leader>rr", vim.lsp.buf.rename, "Rename Symbol (Alt)")
  buf_map("n", "<leader>rf", function()
    vim.lsp.buf.format { async = true }
  end, "Format Document")
  buf_map("n", "<leader>rh", vim.lsp.buf.hover, "Hover")
  buf_map("n", "<leader>rs", vim.lsp.buf.signature_help, "Signature Help")
  buf_map("n", "<leader>rd", vim.lsp.buf.definition, "Definition")
  buf_map("n", "<leader>ri", vim.lsp.buf.implementation, "Implementation")
  buf_map("n", "<leader>rR", vim.lsp.buf.references, "References")
  buf_map("n", "<leader>rc", vim.lsp.codelens.run, "Run CodeLens")
  buf_map("n", "<leader>cl", vim.lsp.codelens.run, "Run CodeLens (Alt)")
  buf_map("n", "<leader>f", function()
    vim.lsp.buf.format { async = true }
  end, "Format Document (Alt)")

  buf_map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")
end

lsp.config("gopls", {
  cmd = { "gopls" },
  root_markers = { "go.work", "go.mod", ".git" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
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
})

lsp.config("dotnet", {
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
})

lsp.config("protols", {
  cmd = { "protols" },
  filetypes = { "proto" },
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
})

lsp.config("pyright", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
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
})

lsp.config("htmx-lsp", {
  on_init = on_init,
  on_attach = o_attach_extended,
  capabilities = cmp_capabilities,
  filetypes = { "html", "css", "js" },
})

lsp.config("cssls", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
  filetypes = { "css", "scss", "less" },
})

lsp.config("clangd", {
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  on_init = on_init,
  on_attach = function(client, bufnr)
    on_attach_extended(client, bufnr)
    client.offset_encoding = "utf-16"
  end,
  capabilities = cmp_capabilities,
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
})

lsp.config("lua_ls", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
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
})

lsp.config("gradle_ls", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
})

lsp.config("prismals", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
})

lsp.config("vue_ls", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
})

lsp.config("sql-language-server", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
  filetypes = { "sql", "mysql" },
})

lsp.config("html", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
  filetypes = { "html", "templ" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
  },
  single_file_support = true,
})

lsp.config("jsonls", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = true,
  },
  single_file_support = true,
})

lsp.config("dockerls", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
  filetypes = { "dockerfile" },
  single_file_support = true,
})

lsp.config("marksman", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
  filetypes = { "markdown", "markdown.mdx" },
  single_file_support = true,
})

lsp.config("taplo", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
  filetypes = { "taplo", "lsp", "stdio" },
  single_file_support = true,
})

lsp.config("vtsls", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
  cmd = { "typescript-language-server", "-stdio" },
  single_file_support = true,
})

lsp.config("yamlls", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  single_file_support = true,
  settings = {
    redhat = { telemetry = { enabled = false } },
  },
})

lsp.config("typos_lsp", {
  cmd = { "typos-lsp" },
  cmd_env = {
    RUST_LOG = "error",
  },

  root_markers = {
    ".git",
    "types.toml",
    ".types.toml",
    "_types.toml",
  },

  filetypes = {
    "go",
    "lua",
    "python",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "markdown",
    "html",
    "css",
  },

  single_file_support = true,

  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
})

lsp.config("tailwindcss", {
  on_init = on_init,
  on_attach = on_attach_extended,
  capabilities = cmp_capabilities,
  cmd = { "tailwindcss-language-server", "--stdio" },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
  },
  filetypes = {
    "aspnetcorerazor",
    "astro",
    "astro-markdown",
    "blade",
    "clojure",
    "django-html",
    "htmldjango",
    "edge",
    "eelixir",
    "elixir",
    "ejs",
    "erb",
    "eruby",
    "gohtml",
    "gohtmltmpl",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "htmlangular",
    "html-eex",
    "heex",
    "jade",
    "leaf",
    "liquid",
    "markdown",
    "mdx",
    "mustache",
    "njk",
    "nunjucks",
    "razor",
    "slim",
    "twig",
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    "sugarss",
    "javascript",
    "javascriptreact",
    "reason",
    "rescript",
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
        "class:list",
        "classList",
        "ngClass",
      },
      includeLanguages = {
        scss = "css",
        eelixir = "html-eex",
        eruby = "erb",
        htmlangular = "html",
        templ = "html",
      },
      experimental = {
        classRegex = {
          { "@apply ([^;]*)", "([^\\s]*)" },
          { "apply%(([^)]*)%)", "([^%s%']+)" },
        },
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
  workspace_required = true,
})

vim.lsp.enable "gopls"
vim.lsp.enable "dotnet"
vim.lsp.enable "protols"
vim.lsp.enable "pyright"
vim.lsp.enable "htmx-lsp"
vim.lsp.enable "cssls"
vim.lsp.enable "clangd"
vim.lsp.enable "lua_ls"
vim.lsp.enable "gradle_ls"
vim.lsp.enable "prismals"
vim.lsp.enable "vue_ls"
vim.lsp.enable "sql-language-server"
vim.lsp.enable "html"
vim.lsp.enable "jsonls"
vim.lsp.enable "dockerls"
vim.lsp.enable "tailwindcss"
vim.lsp.enable "taplo"
vim.lsp.enable "yamlls"
vim.lsp.enable "vtsls"
vim.lsp.enable "typos_lsp"
