return{
  "folke/persistence.nvim",
  event = "BufReadPre", -- load early to restore sessions
  opts = {
    options = { "buffers", "curdir", "tabpages", "winsize" },
  },
}

