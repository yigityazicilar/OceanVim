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

require("core/vim_settings")
require("plugins")
require("core/autocmds")
require("core/mappings")

local M = {}

M.icons = {
    diagnostics = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
    },
    git = {
        added = " ",
        modified = " ",
        removed = " ",
    },
    cmp = {
        Array = " ",
        Boolean = " ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Copilot = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = " ",
        Key = " ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Namespace = " ",
        Null = " ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        String = " ",
        Struct = "פּ ",
        Table = " ",
        Tag = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
    },
}

return M
