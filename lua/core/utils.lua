local M = {}

-- Checks if a String s starts with the given String start.
M.startswith = function(s, start)
    return string.sub(s, 1, #start) == start
end

-- Set the leader to be the given key.
M.setLeader = function(key)
    vim.g.mapleader = key
    vim.g.maplocalleader = key
    vim.keymap.set({ 'n', 'v' }, key, '<nop>', { silent = true })
end

-- Not used right now but if which key does not work might need to switch back.
M.map = function(mode, lhs, rhs, description, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    if description then
        options = vim.tbl_extend("force", options, { desc = description })
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
