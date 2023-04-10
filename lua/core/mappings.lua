local wk = require("which-key")

local function map(mode, lhs, rhs, description, opts)
    local options = { noremap=true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    if description then
        options = vim.tbl_extend("force", options, { desc = description })
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

------------------------- Normal ----------------------------
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", { expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", { expr = true })

------------------------- Insert ----------------------------
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

------------------------- Visual ----------------------------
map("v", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", { expr = true })
map("v", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", { expr = true })

map("x", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", { expr = true })
map("x", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", { expr = true })

