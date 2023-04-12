local options = {
    filters = {
        dotfiles = true,
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    popup_border_style = "rounded",
    update_focused_file = {
        enable = true,
        update_root = false,
    },
    view = {
        adaptive_size = false,
        side = "left",
        width = 30,
        hide_root_folder = true,
        preserve_window_proportions = true,
    },
    git = {
        enable = false,
        ignore = false,
    },
    actions = {
        open_file = {
            resize_window = true,
            quit_on_open = true,
        },
    },
    renderer = {
        highlight_git = false,
        highlight_opened_files = "none",
        indent_markers = {
            enable = false,
        },
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = false,
            },
        },
    },
}

return options
