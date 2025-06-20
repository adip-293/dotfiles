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
vim.keymap.set("n", "<leader>sc",  function() Snacks.input.enable() end, { desc = "Open Grep" })

vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore Session" })
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Session" })

vim.keymap.set("n", "<leader>fo", "<cmd>Oil<CR>", { desc = "Open Oil (Current Dir)" })

vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash Jump" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "c" }, "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = vim.api.nvim_buf_set_keymap

    map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    map(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    map(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    map(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    map(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    map(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    map(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  end,
})









