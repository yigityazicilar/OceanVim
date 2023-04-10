local wk = require("which-key")

local options = {
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" }
    },
    on_attach = function(bufnr)
        wk.register({
            g = {
                name = "+git",
                b = { function() require("gitsigns").blame_line() end, "Git Blame" }
            },
        }, { prefix = "<leader>", buffer = bufnr })
    end,
}

return options
