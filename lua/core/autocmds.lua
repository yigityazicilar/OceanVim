local autocmd = vim.api.nvim_create_autocmd

local augroup = function(name)
    return vim.api.nvim_create_augroup("oceannv_" .. name, { clear = true })
end

-- Close Quickfix Menu after selection.
autocmd(
    "FileType",
    {
        pattern = {"qf"},
        command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
    }
)

autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "qf",
        "TelescopePrompt",
        "lspinfo",
        "man",
        "startuptime",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>q!<cr>", { buffer = event.buf, silent = true })
    end,
})
