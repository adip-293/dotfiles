vim.g.mapleader = " "

-- Telescope keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<leader>ff', "<cmd>Telescope find_files<cr>", opts)
map('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", opts)
map('n', '<leader>fb', "<cmd>Telescope buffers<cr>", opts)
map('n', '<leader>fh', "<cmd>Telescope help_tags<cr>", opts)

-- Neo-tree keymap
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = "Toggle Neo-tree" })

-- Oil file manager keymap
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory (oil.nvim)", noremap = true, silent = true })

vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<Cmd>bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", { desc = "Close buffers to right" })
vim.keymap.set("n", "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Close buffers to left" })


