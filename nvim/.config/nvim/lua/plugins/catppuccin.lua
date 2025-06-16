return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- make sure this loads before any other UI plugins
    config = function()
      vim.g.catppuccin_flavour = "mocha"

      require("catppuccin").setup({
        integrations = {
          bufferline = true,
          cmp = true,
          gitsigns = true,
          treesitter = true,
          native_lsp = {
            enabled = true,
          },
        },
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

