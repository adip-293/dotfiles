return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy", -- This is okay because Catppuccin loads first (priority = 1000)
  config = function()
    local mocha = require("catppuccin.palettes").get_palette("mocha")
    local bufferline_catppuccin = require("catppuccin.groups.integrations.bufferline")

    require("bufferline").setup({
      options = {
        mode = "buffers",
        numbers = "none",
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        show_buffer_close_icons = true,
        show_close_icon = false,
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
      highlights = bufferline_catppuccin.get({
        styles = { "italic", "bold" },
        custom = {
          all = {
            fill = { bg = mocha.base },
          },
          mocha = {
            background = { fg = mocha.text },
          },
        },
      }),
    })
  end,
}

