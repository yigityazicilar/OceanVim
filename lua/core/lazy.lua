local lazyPath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local lazySource = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazyPath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        lazySource,
        "--branch=stable",
        lazyPath,
    })
end

vim.opt.rtp:prepend(lazyPath)

local ok, lazy = pcall(require, "lazy")
if not ok then
    return
end

lazy.setup("plugins", {
    defaults = {
        lazy = true,
    },
    install = {
        missing = true,
        colorscheme = { "catppuccin" },
    },
})

require("keymaps/vim")
