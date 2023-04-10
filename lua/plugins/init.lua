local base_plugins = {
    {
        'nvim-lua/plenary.nvim'
    },

    -------- Keybind Viewer --------
    {
        "folke/which-key.nvim",
        keys = { "<leader>" }
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufRead", "BufNewFile", "BufWinEnter" },
        build = ":TSUpdate",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSBufToggle", "TSModuleInfo" },
        opts = function()
            return require("plugins.options.treesitter")
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        opts = function()
            return require("plugins.options.mason")
        end,
        config = function(_, opts)
            require("mason").setup(opts)

            vim.api.nvim_create_user_command(
                "MasonInstallAll",
                function()
                    vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
                end,
                {}
            )
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufRead", "BufNewFile", "BufWinEnter" },
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } }
        },
        opts = {
            diagnostics = {
                severity_sort = true,
                virtual_text = { spacing = 4, prefix = "" },
            }
        },
        config = function(_, opts)
            require("plugins.options.lspconfig")

            for name, icon in pairs(require("core").icons.diagnostics) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = name })
            end
            vim.diagnostic.config(opts.diagnostics)
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",
                dependencies = {
                    "rafamadriz/friendly-snippets"
                },
                opts = { history = true, updateevents = "TextChanged,TextChangedI", },
                config = function(_, opts)
                    require("luasnip").config.set_config(opts)
                end,
            },

            {
                "windwp/nvim-autopairs",
                opts = {
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },

            {
                "ray-x/lsp_signature.nvim",
            },

            {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            }
        },
        opts = function()
            return require("plugins.options.nvim-cmp")
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        init = function()
            require("plugins.options.telescope").init()
        end,
        opts = function()
            return require("plugins.options.telescope").options
        end,
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)

            for _, ext in ipairs(opts.extensions_list) do
                telescope.load_extension(ext)
            end
        end,
    },

    {
        "nvim-tree/nvim-web-devicons"
    },

    {
        "rebelot/heirline.nvim",
        event = "UIEnter",
        opts = function()
           return require("plugins.options.heirline")
        end,
        config = function(_, opts)
           require("heirline").setup(opts)
        end,
    }, 
}

local colorschemes = require("plugins/colorschemes")
table.insert(base_plugins, colorschemes)

require("lazy").setup(base_plugins, require("plugins.options.lazy_nvim"))
