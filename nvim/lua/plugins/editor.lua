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
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      opts.fzf_opts = {}
    end,
    keys = {
      { "<leader>/", false },
    },
  },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   keys = {
  --     { "<leader>/", false },
  --   },
  --   -- opts = {
  --   --   defaults = {
  --   --     layout_strategy = "vertical",
  --   --     layout_config = { prompt_position = "top" },
  --   --     sorting_strategy = "ascending",
  --   --     winblend = 0,
  --   --   },
  --   -- },
  -- },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    -- REMOVE THIS once this issue is fixed: https://github.com/yioneko/vtsls/issues/159
    opts = {
      routes = {
        {
          filter = {
            event = "notify",
            find = "Request textDocument/inlayHint failed",
          },
          opts = { skip = true },
        },
      },
    },
  },
}
