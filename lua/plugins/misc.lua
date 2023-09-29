return {
    { "nvim-lua/plenary.nvim" },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {},
    },

    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {},
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            use_diagnostic_signs = true,
        },
        init = function()
            -- require("keymaps.misc").trouble()
        end,
    },

    { -- Look into the keymaps of this to add using which-key.
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
        init = function()
            -- require("keymaps.misc").todo()
        end,
    },

    {
        "rcarriga/nvim-notify",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        module = true,
        opts = {
            timeout = 100,
            fps = 60,
            top_down = true,
        },
        config = function(_, opts)
            require('notify').setup(opts)
            vim.notify = require('notify')
        end
    },

    -- [TODO] Look into adding a colorizer plugin. They can be very useful for UI development. 

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            exclude = {
                filetypes = {
                    "help",
                    "checkhealth",
                    "man",
                    "gitcommit",
                    "terminal",
                    "lazy",
                    "lspinfo",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "mason",
                    "",
                }
            },
        },
    },

    -- Enable some plugins to repeat their last command when "." is pressed.
    { "tpope/vim-repeat", event = "VeryLazy" },
}
