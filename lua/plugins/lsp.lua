local language_servers = {
    "lua_ls",
    "clangd",
    "rust_analyzer",
    "pylsp",
    "jsonls",
}

local signature_config = {
    bind = true,
    handler_opts = {
        border = "rounded",
    },
    hint_prefix = " ",
}

local capabilities = nil
local get_capabilities = function()
    if capabilities == nil then
        capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )
    end
    return capabilities
end

local on_attach = function(client, bufnr)
    require("lsp_signature").on_attach(signature_config, bufnr)
    require("lsp-format").on_attach(client)
end

return {
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
            "lukas-reineke/lsp-format.nvim",
            "folke/neodev.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "ray-x/lsp_signature.nvim",
        },
        config = function ()
            require("mason").setup()
            require("fidget").setup()
            require("neodev").setup()

            require("mason-lspconfig").setup({
                ensure_installed = language_servers,
                automatic_installation = true
            })

            require("lsp-format").setup()

            local lsp = require("lspconfig")
            local ls_config = {}
            ls_config["lua_ls"] = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Both",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                                [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                            },
                            maxPreload = 100000,
                            preloadFileSize = 10000,
                        },
                    },
                },
            }

            for _, ls in pairs(language_servers) do
                if ls_config[ls] == nil then
                    ls_config[ls] = {
                        capabilities = get_capabilities(),
                        on_attach = on_attach,
                    }
                else
                    ls_config[ls].capabilities = get_capabilities()
                    ls_config[ls].on_attach = on_attach
                end
                lsp[ls].setup(ls_config[ls])
            end
        end
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    },

    -- [TODO] Look into Rust Tools
    -- https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
}
