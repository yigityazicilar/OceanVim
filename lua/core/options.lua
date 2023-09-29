local opt = vim.opt
local g   = vim.g

-- Set the default colorscheme.
g.OceanNV_Colorscheme = "catppuccin"

opt.clipboard = "unnamedplus"
opt.cursorline = true

opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.fillchars = { eob = " " }

opt.ignorecase = true
opt.smartcase = true

opt.number = true
opt.numberwidth = 4

opt.termguicolors = true

opt.laststatus = 3
opt.showmode = false
opt.undolevels = 100000

opt.completeopt = { "menu", "menuone", "noselect" }
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"
