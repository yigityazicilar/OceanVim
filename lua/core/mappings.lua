local wk = require("which-key")

local function map(mode, lhs, rhs, description, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    if description then
        options = vim.tbl_extend("force", options, { desc = description })
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Making j and k move up and down between lines.
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", { expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", { expr = true })
map("v", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", { expr = true })
map("v", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", { expr = true })
map("x", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", { expr = true })
map("x", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", { expr = true })
-- Remapping jk and kj to be escape.
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
        border = "double",
    },
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
})

function _lazygit_toggle()
    lazygit:toggle()
end

wk.register({
    t = {
        name = "+trouble/terminal",
        t = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
        v = { "<cmd>ToggleTerm dir=git_dir direction=vertical size=80<cr>", "Vertical Terminal" },
        g = { "<cmd>lua _lazygit_toggle()<cr>", "Lazygit Open"},
    }
}, { prefix = "<leader>" })

wk.register({
    ["<C-h>"] = { "<cmd>wincmd h<cr>", "Window Left"},
    ["<C-j>"] = { "<cmd>wincmd j<cr>", "Window Up"},
    ["<C-k>"] = { "<cmd>wincmd k<cr>", "Window Down"},
    ["<C-l>"] = { "<cmd>wincmd l<cr>", "Window Right"},
})

wk.register({
    ["<C-h>"] = { "<cmd>wincmd h<cr>", "Window Left"},
    ["<C-j>"] = { "<cmd>wincmd j<cr>", "Window Up"},
    ["<C-k>"] = { "<cmd>wincmd k<cr>", "Window Down"},
    ["<C-l>"] = { "<cmd>wincmd l<cr>", "Window Right"},
}, { mode = "t" })
