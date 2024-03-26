local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "dartls"
    end,
    bufnr = bufnr,
  })
end

local flutter_on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
  {
    "neovim/nvim-lspconfig",
    -- other settings removed for brevity
    opts = {
      servers = {
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = {},
          -- to fully override the default_config, change the below
          -- filetypes = {}
        },
        tsserver = {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "/Users/sedanayoga/.config/nvim/node_modules/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
              },
            },
          },
          filetypes = {
            "javascript",
            "typescript",
            "vue",
          },
        },
      },
      setup = {
        tailwindcss = function(_, opts)
          local tw = require("lspconfig.server_configurations.tailwindcss")
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, tw.default_config.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
        eslint = function()
          local function get_client(buf)
            return require("lazyvim.util").lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end

          local formatter = require("lazyvim.util").lsp.formatter({
            name = "eslint: lsp",
            primary = false,
            priority = 200,
            filter = "eslint",
          })

          -- Use EslintFixAll on Neovim < 0.10.0
          if not pcall(require, "vim.lsp._dynamic") then
            formatter.name = "eslint: EslintFixAll"
            formatter.sources = function(buf)
              local client = get_client(buf)
              return client and { "eslint" } or {}
            end
            formatter.format = function(buf)
              local client = get_client(buf)
              if client then
                local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end
          end

          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)

          -- register the formatter with LazyVim
          require("lazyvim.util").format.register(formatter)
        end,
      },
    },
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
    opts = {
      ui = {
        border = "rounded",
      },
      decorations = {
        statusline = {
          app_version = false,
          device = true,
          project_config = false,
        },
      },
      flutter_path = "/Users/sedanayoga/flutter/bin/flutter",
      root_patterns = { ".git", "pubspec.yaml" },
      dev_log = {
        enabled = true,
        notify_errors = false, -- if there is an error whilst running then notify the user
        open_cmd = "tabedit", -- command to use to open the log buffer
      },
      closing_tags = {
        highlight = "Comment",
        prefix = "> ",
        enabled = true,
      },
      lsp = {
        color = { -- show the derived colours for dart variables
          enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
          background = false, -- highlight the background
          background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
          foreground = false, -- highlight the foreground
          virtual_text = true, -- show the highlight using virtual text
          virtual_text_str = "■", -- the virtual text character to highlight
        },
        on_attach = flutter_on_attach,
        capabilities = capabilities, -- e.g. lsp_status capabilities
        --- OR you can specify a function to deactivate or change or control how the config is created
        -- capabilities = function(config)
        -- 	config.specificThingIDontWant = false
        -- 	return config
        -- end,
        -- see the link below for details on each option:
        -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          -- analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
          renameFilesWithClasses = "prompt", -- "always"
          enableSnippets = true,
          updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
        },
      },
    },
  },
}
