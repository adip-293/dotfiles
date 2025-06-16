-- lua/plugins/alpha.lua
return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- For icon support
  event = 'VimEnter',
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    dashboard.section.header.val = {
      "                                                                     ",
      "       ████ ██████           █████      ██                     ",
      "      ███████████             █████                             ",
      "      █████████ ███████████████████ ███   ███████████   ",
      "     █████████  ███    █████████████ █████ ██████████████   ",
      "    █████████ ██████████ █████████ █████ █████ ████ █████   ",
      "  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
      " ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
      dashboard.button("g", "󰱼  Live Grep", ":Telescope live_grep<CR>"),
      dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    dashboard.section.footer.val = {
      "",
      "Welcome back, coder.",
    }

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}

