 vim.g.mapleader=" "

-- Telescope keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Oil file manager keymap
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory (oil.nvim)", noremap = true, silent = true })

vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<Cmd>bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", { desc = "Close buffers to right" })
vim.keymap.set("n", "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Close buffers to left" })

vim.keymap.set("n", "<leader>e",   function() Snacks.explorer() end, { desc = "Open Snacks Explorer" })
vim.keymap.set("n", "<leader>ff",  function() Snacks.picker.files() end, { desc = "Open Snacks File Picker" })
vim.keymap.set("n", "<leader>fb",  function() Snacks.picker.buffers() end, { desc = "Open Snacks Buffer Picker" })
vim.keymap.set("n", "<leader>fp",  function() Snacks.picker.projects() end, { desc = "Open Snacks Project Picker" })
vim.keymap.set("n", "<leader>fr",  function() Snacks.picker.recent() end, { desc = "Open Snacks Recent Picker" })
vim.keymap.set("n", "<leader>fg",  function() Snacks.picker.grep() end, { desc = "Open Grep" })
vim.keymap.set("n", "<leader>fo",  function() Snacks.picker.grep_buffers() end, { desc = "Open Grep" })
vim.keymap.set("n", "<leader>fw",  function() Snacks.picker.grep_word() end, { desc = "Open Grep" })
vim.keymap.set("n", "<leader>gb",  function() Snacks.gitbrowse() end, { desc = "Open Grep" })
vim.keymap.set("n", "<leader>gt",  function() Snacks.lazygit() end, { desc = "Open Grep" })









