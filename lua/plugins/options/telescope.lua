local wk = require("which-key")
local M = {}

M.init = function()
    wk.register({
        f = {
            name = "+file",
            f = { "<cmd>Telescope find_files<cr>", "Find File" },
            r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" }
        }
    }, { prefix = "<leader>" })

    wk.register({
        t = {
            p = { "<cmd>Telescope themes<cr>", "Theme Picker" },
        }
    }, { prefix = "<leader>" })
end

M.options = {
    defaults = {
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.9,
            height = 0.8,
            preview_cutoff = 120,
        },
        prompt_prefix = "  ",
        border = {},
        path_display = { "truncate" },
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        file_ignore_patterns = { "node_modules" },
    },

    extensions_list = { },
}

return M
