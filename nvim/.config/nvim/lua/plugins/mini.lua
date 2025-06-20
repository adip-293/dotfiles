return{
  "echasnovski/mini.cursorword",
  event = "BufReadPost", -- load on file open
  config = function()
    require("mini.cursorword").setup()
  end,
}
