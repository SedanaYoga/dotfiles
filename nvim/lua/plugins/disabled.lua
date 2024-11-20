return {
  -- disable trouble
  { "rcarriga/nvim-notify", enabled = false },
  { "nvimdev/dashboard-nvim", enabled = false },
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        top_down = false,
      },
      dashboard = {
        enabled = false,
      },
    },
  },
}
