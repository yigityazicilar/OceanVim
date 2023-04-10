local autocmd = vim.api.nvim_create_autocmd

-- Close Quickfix Menu after selection.
autocmd(
    "FileType",
    {
        pattern = {"qf"},
        command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
    }
)

