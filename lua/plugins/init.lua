local base_plugins = {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },

    {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
    },

    {
        "folke/neodev.nvim",
    },
}



require("lazy").setup(base_plugins, require("plugins.options.lazy_nvim"))
