return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {},
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- opts will be merged with the parent spec
    opts = {
      window = {
        position = "right",
        width = 50,
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignore = false,
          hide_hidden = false,
        },
      },
    },
  },
}
