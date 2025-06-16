-- lua/plugins/telescope.lua
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required dependency
    'nvim-telescope/telescope-fzf-native.nvim', -- Optional but recommended
  },
  build = 'make', -- Needed for telescope-fzf-native
  lazy = true,
  cmd = 'Telescope',
  keys = {
    -- Leave empty; we define keymaps in config/keymaps.lua
  },
  config = function()
    require('telescope').setup({
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
        winblend = 0,
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    })

    -- Load FZF extension if installed
    pcall(require('telescope').load_extension, 'fzf')
  end,
}

