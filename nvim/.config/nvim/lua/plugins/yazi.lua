return {
  "mikavilpas/yazi.nvim",
  lazy = false, -- Load immediately (or set to true and configure with keys)
  keys = {
    { "<leader>fy", function() require("yazi").yazi() end, desc = "Open Yazi" },
  },
  config = function()
    require("yazi").setup({
      -- Optional config
      open_for_directories = true,
    })
  end,
}

