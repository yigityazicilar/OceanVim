local utils = require("core.utils")

-- Setting <SPC> to be the leader.
utils.setLeader(" ")

-- Load the default neovim options.
require("core.options")

-- Lazily load the plugins.
require("core.lazy")

local csOK, _ = pcall(vim.cmd.colorscheme, vim.g.OceanNV_Colorscheme)
if not csOK then
    vim.notify("The colorscheme inside OceanNV_Colorscheme cannot be loaded", "error")
    pcall(vim.cmd.colorscheme, "catppuccin")
end
