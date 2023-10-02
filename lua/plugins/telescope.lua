return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "tsakirist/telescope-lazy.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
        {
            "nvim-telescope/telescope-file-browser.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
            },
        },
    },
    cmd = { "Telescope" },
    init = function ()
        -- require("keymaps.telescope")
    end,
    config = function ()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                prompt_prefix = "  ",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                    },
                },
                -- Not removing borders. If it does not look great remove with {}.
                border = true,
                path_display = { "smart" }, -- If it acts slow change to "truncate".
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
            extensions = {
                file_browser = {
                    hijack_netrw = true,
                }
            }
        })


        local extension_list = {
            "lazy",
            "fzf",
            "file_browser",
        }

        for _, ext in ipairs(extension_list) do
            telescope.load_extension(ext)
        end
    end,
}
