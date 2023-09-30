return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" }
            },
        },
        on_attach = function(bufnr)
            require("keymaps.misc").gitsigns(bufnr)
        end,
    }
}
