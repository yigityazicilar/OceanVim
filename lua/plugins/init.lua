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
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        opts = function()
            return require("plugins.options.mason").mason
        end,
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "UIEnter",
        dependencies = {
            "williamboman/mason.nvim"
        },
        opts = function()
            return require("plugins.options.mason").mason_lspconfig
        end,
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
        end,
    },


    {
        "neovim/nvim-lspconfig",
        event = { "BufRead", "BufNewFile", "BufWinEnter" },
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf",                                config = true },
            { "folke/neodev.nvim",  opts = { experimental = { pathStrict = true } } }
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
        dependencies = {
            "tsakirist/telescope-lazy.nvim",
            -- {
            --     'cljoly/telescope-repo.nvim',
            --     dependencies = {
            --
            --     }
            -- }
        },
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
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = function()
            return require("plugins.options.heirline")
        end,
        config = function(_, opts)
            require("heirline").setup(opts)
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        ft = "gitcommit",
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                        vim.schedule(function()
                            require("lazy").load { plugins = { "gitsigns.nvim" } }
                        end)
                    end
                end,
            })
        end,
        opts = function()
            return require("plugins.options.gitsigns")
        end,
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },

    {
        "numToStr/Comment.nvim",
        init = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>c"] = { function() require("Comment.api").toggle.linewise.current() end, "Comment Line" }
            })
            wk.register({
                ["<leader>c"] = { "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
                    "Comment Line" }
            }, { mode = "v" })
        end,
        config = function()
            require("Comment").setup({
                mappings = false
            })
        end,
    },

    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("trouble").setup({
                use_diagnostic_signs = true,
            })
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        config = function()
            require("toggleterm").setup()
        end,
    },

    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        cmd = "Neorg",
        opts = {
            load = {
                ["core.defaults"] = {},       -- Loads default behaviour
                ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.norg.dirman"] = {      -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            university = "~/notes/uni",
                            home = "~/notes/home",
                        },
                    },
                },
                ["core.norg.completion"] = {
                    config = {
                        engine = "nvim-cmp"
                    }
                },
                ["core.integrations.nvim-cmp"] = {},
            },
        },
    }
}

local colorschemes = require("plugins/colorschemes")
table.insert(base_plugins, colorschemes)

require("lazy").setup(base_plugins, require("plugins.options.lazy_nvim"))
