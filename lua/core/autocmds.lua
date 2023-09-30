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

-- Make Quickfix, TelescopePrompt, LSP information, manual pages, and the startup time screens to close with "q".
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

autocmd("LspAttach", {
    group = augroup("LspConfig"),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        -- [TODO] require('keymaps.lsp').lsp()
    end
})
