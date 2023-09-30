return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "RRethy/vim-illuminate",
        },
        event = "VeryLazy",
        opts = {
            auto_install = true,
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    }
}
