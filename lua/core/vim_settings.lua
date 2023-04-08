local opt = vim.opt
local g   = vim.g

-- Options
opt.clipboard = "unnamedplus"

-- Indents
opt.expandtab = true
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.ignorecase = true
opt.smartcase = true

opt.number = true
opt.numberwidth = 2
opt.ruler = false

opt.termguicolors = true

opt.undolevels = 1000000

g.mapleader = " "
