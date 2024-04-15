return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
      "thenbe/neotest-playwright",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-playwright").adapter({
            options = {
              persist_project_selection = true,
              enable_dynamic_test_discovery = true,
              preset = "headed",
            },
          }),
          require("neotest-vitest"),
        },
      })
    end,
  },
}
