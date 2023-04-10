local M = {}

M.startswith = function(s, start)
    return string.sub(s, 1, #start) == start
end

return M
