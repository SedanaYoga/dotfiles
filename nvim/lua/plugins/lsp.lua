return {
  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                library = {
                  "${3rd}/love2d/library",
                },
              },
            },
          },
        },
        tailwindcss = {
          root_dir = function(fname)
            local node_modules = vim.fs.find("node_modules", { path = fname, upward = true })[1]
            local root = vim.fs.dirname(node_modules)
            if not node_modules then
              return nil
            else
              local tailwind_path = node_modules .. "/tailwindcss"

              if vim.fn.isdirectory(tailwind_path) ~= 0 then
                return root
              else
                return nil
              end
            end
          end,
        },
      },

      setup = {
        eslint = function()
          local function get_client(buf)
            return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end

          local formatter = LazyVim.lsp.formatter({
            name = "eslint: lsp",
            primary = false,
            priority = 200,
            filter = "eslint",
          })

          -- Use EslintFixAll on Neovim < 0.10.0
          -- Changed from upstream: check the version explicitly instead of
          -- looking for `vim.lsp._require`. Seems like that check stopped working
          -- with Neovim 0.11.
          if vim.fn.has("nvim-0.10") == 0 then
            formatter.name = "eslint: EslintFixAll"
            formatter.sources = function(buf)
              local client = get_client(buf)
              return client and { "eslint" } or {}
            end
            formatter.format = function(buf)
              local client = get_client(buf)
              if client then
                local pull_diagnostics =
                  vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id, false) })
                -- Older versions of the ESLint language server send push
                -- diagnostics rather than using pull. We support both for
                -- backwards compatibility.
                local push_diagnostics =
                  vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id, true) })
                if (#pull_diagnostics + #push_diagnostics) > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end
          end

          -- register the formatter with LazyVim
          LazyVim.format.register(formatter)
        end,
      },
    },
  },
}
