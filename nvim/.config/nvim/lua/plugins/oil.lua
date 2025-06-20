return{
  "stevearc/oil.nvim",
  opts = {
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<C-h>"] = false, -- disable built-in mappings if you want custom ones
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

