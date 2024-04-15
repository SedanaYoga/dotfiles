return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
          },
        },
      },
    },
  },
}
