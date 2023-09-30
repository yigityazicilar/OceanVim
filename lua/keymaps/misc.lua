local wk = require("whick-key")
local misc = {}
local prefix = { prefix = "<leader>" }

misc.spider = function()
    wk.register({
        ["w"] = {
            "<cmd>lua require(spider).motion('w')<CR>",
            "Spider-w"
        },
        ["e"] = {
            "<cmd>lua require(spider).motion('e')<CR>",
            "Spider-e"
        },
        ["b"] = {
            "<cmd>lua require(spider).motion('b')<CR>",
            "Spider-b"
        },
        ["ge"] = {
            "<cmd>lua require(spider).motion('ge')<CR>",
            "Spider-ge"
        },
    })
end

misc.gitsigns = function(bufnr)
    wk.register({
        g = {
            name = "+git",
            b = { function() require("gitsigns").blame_line() end, "Git Blame" }
        },
    }, { prefix = "<leader>", buffer = bufnr })
end

return misc
