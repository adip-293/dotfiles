return {
  "folke/snacks.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  priority = 1000,
  lazy = false,
   opts = {
    picker = {enabled = true}, --Nice
    bigfile = {enabled = true}, --Allegedly Nice
    explorer = {enabled = true}, --Nice
    indent = {enabled = true}, --Nice
    scroll = {enabled = true}, --Nice
    gitbrowse = {enabled = true}, --Nice
    lazygit = {enabled = true}, --Nice
    notifier = {enabled = true}, --Alright
    quickfile = {enabled = true}, --Allegedly Nice
    dashboard = {--Nice
      enabled = true,
      preset = {
        header = [[
                                                                     
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████ 
        ]],
      },
    },
  },
}

