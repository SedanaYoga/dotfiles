local startupNeotree = vim.api.nvim_create_augroup("neotree", { clear = true })
vim.api.nvim_create_autocmd("UiEnter", {
  desc = "Open Neotree automatically",
  group = startupNeotree,
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("Neotree toggle")
    end
  end,
})
