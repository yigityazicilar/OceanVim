local M = {}

M.mason = {
    PATH = "skip",

    max_concurrent_installers = 8,
}

M.mason_lspconfig = {
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "clangd",
    },

    automatic_installation = false,
}

return M
