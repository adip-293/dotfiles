return{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      spelling = true,
    },
    window = {
      border = "rounded",
    },
    layout = {
      spacing = 6,
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register({
      ["<leader>f"] = { name = "+find" },
      ["<leader>b"] = { name = "+buffers" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>q"] = { name = "+sessions" },
      ["<leader>s"] = { name = "+snacks" },
    })
  end,
}

