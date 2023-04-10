local opt = vim.opt
local g   = vim.g

g.mapleader = " "

-- Options
opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indents
opt.expandtab = true
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.fillchars = { eob = " " }

opt.ignorecase = true
opt.smartcase = true

opt.number = true
opt.numberwidth = 2
opt.ruler = false

opt.termguicolors = true
opt.signcolumn = "yes"

opt.laststatus = 3
opt.timeoutlen = 400
opt.undolevels = 1000

opt.completeopt = { "menu", "menuone", "noselect" }

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"
