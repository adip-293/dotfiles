vim.api.nvim_create_autocmd("BufAdd", {
  callback = function()
    vim.schedule(function()
      require("bufferline").setup({
        options = {
          always_show_bufferline = #vim.api.nvim_list_bufs() > 1
        }
      })
    end)
  end,
})

