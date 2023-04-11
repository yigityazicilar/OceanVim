local options = {
    ensure_installed = {
        -- defaults for configuring vim
        "vim",
        "lua",

        -- web development
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "scss",

        -- c languages
        "c",
        "cpp",
        "make",
        "cmake",
        "glsl",

        -- rust
        "rust",
        "toml",

        -- scripting
        "python",
        "bash",

        -- git
        "gitignore",

        -- latex
        "latex",
        "bibtex",
    },

    highlight = {
        enable = true,
    },

    indent = {
        enable = true,
    },
}

return options
