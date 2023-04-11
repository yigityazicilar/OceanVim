local lsp = require("lspconfig")
local wk = require("which-key")

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local signature_config = {
    bind = true,
    handler_opts = {
        border = "rounded",
    },
    hint_prefix = " ",
}

local on_attach = function(client, bufnr)
    require("lsp_signature").on_attach(signature_config, bufnr)

    wk.register({
        l = {
            name = "+lsp",
            D = { function() vim.lsp.buf.declaration({ reuse_win = true }) end, "Show Declaration" },
            d = { function() vim.lsp.buf.definition({ reuse_win = true }) end, "Show Definition" },
            r = { function() vim.lsp.buf.rename() end, "Rename" },
            s = { function() vim.lsp.buf.signature_help() end, "Show Signature" },
            h = { function() vim.lsp.buf.hover() end, "Hover" },
            f = { function() vim.lsp.buf.format { async = true } end, "Format Document" },
        },
    }, { prefix = "<leader>", buffer = bufnr })
end

local servers = {"rust_analyzer"}

lsp.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";")
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})

lsp.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

for _, server in ipairs(servers) do
    lsp[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
