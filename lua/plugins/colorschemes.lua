local utils = require("core.utils")
local colorscheme = vim.g.ocean_theme

local colorschemes = {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        cond = utils.startswith(colorscheme, "catppuccin"),
        event = { "UIEnter" },
        config = function()
            require("catppuccin").setup()
            vim.cmd([[colorscheme catppuccin-macchiato]])
        end,
    },

    {
        'ishan9299/nvim-solarized-lua',
        priority = 1000,
        cond = utils.startswith(colorscheme, "solarized"),
        event = { "UIEnter" },
        config = function()
            vim.cmd([[colorscheme solarized]])
        end,
    },
}

return colorschemes
