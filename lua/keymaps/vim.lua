local wk = require("which-key")

wk.register ({
    ["j"] = { '<cmd>v:count || mode(1)[0:1] == "no" ? "j" : "gj"<cr>', 'Move Down' },
    ["k"] = { '<cmd>v:count || mode(1)[0:1] == "no" ? "k" : "gk"<cr>', 'Move Up' },
}, {
    mode = { "n", "v", "x" },
    expr = true,
})

wk.register({
    ["jk"] = { "<Esc>", "Exit insert mode" },
    ["kj"] = { "<Esc>", "Exit insert mode" },
}, {
    mode = { "i" }
})

wk.register({
    ["<C-h>"] = { "<cmd>wincmd h<cr>", "Window Left" },
    ["<C-j>"] = { "<cmd>wincmd j<cr>", "Window Up" },
    ["<C-k>"] = { "<cmd>wincmd k<cr>", "Window Down" },
    ["<C-l>"] = { "<cmd>wincmd l<cr>", "Window Right" },
}, {
    mode = { "n", "t" }
})
