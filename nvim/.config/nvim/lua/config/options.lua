-- lua/config/options.lua

local opt = vim.opt
local g = vim.g

-- General
opt.mouse = "a"                   -- Enable mouse
opt.clipboard = "unnamedplus"    -- System clipboard
opt.swapfile = false             -- Disable swap
opt.backup = false               -- Disable backup
opt.undofile = true              -- Persistent undo
opt.confirm = true               -- Confirm to save changes when closing
opt.updatetime = 250             -- Faster completion
opt.timeoutlen = 400             -- Shorter key timeout
opt.hidden = true                -- Allow buffer switching without saving

-- UI
opt.number = true                -- Show line numbers
opt.relativenumber = true        -- Relative line numbers
opt.cursorline = true            -- Highlight current line
opt.termguicolors = true         -- True color
opt.signcolumn = "yes"           -- Always show sign column
opt.laststatus = 3               -- Global statusline (lualine compatible)
opt.splitright = true            -- Vertical splits to the right
opt.splitbelow = true            -- Horizontal splits below
opt.scrolloff = 8                -- Keep cursor centered vertically

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- File and Path
opt.autoread = true
opt.wildmenu = true
opt.wildmode = { "longest", "list", "full" }
opt.completeopt = { "menu", "menuone", "noselect" }

-- UI Enhancements for Telescope, Neo-tree, etc.
opt.fillchars = {
  vert = "│",
  fold = " ",
  eob = " ", -- hide ~
  diff = "╱",
  msgsep = "‾",
}

-- Disable built-in plugins we don't use (improves startup)
local disabled_built_ins = {
  "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
  "getscript", "getscriptPlugin", "vimball", "vimballPlugin",
  "2html_plugin", "matchit", "matchparen", "logiPat", "rrhelper",
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
}
for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

