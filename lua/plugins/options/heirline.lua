local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local palette = require("catppuccin.palettes").get_palette("macchiato")
local colors = {
    bg = palette.base,
    fg = palette.text,
    red = palette.red,
    green = palette.green,
    peach = palette.peach,
    sapphire = palette.sapphire,
    mauve = palette.mauve,
    sky = palette.sky,
    dark = palette.mantle
}
require("heirline").load_colors(colors)

local Space = { provider = " " }

local OpenLogo = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = "█",
    hl = function(self)
        return { fg = self.icon_color }
    end
}
local LogoSlant = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = "",
    hl = function(self)
        return { fg = self.icon_color }
    end
}
local Align = { provider = "%=", hl = { fg = "bg" } }

local mode_names = {
    n = "NORMAL",
    no = "NORMAL",
    nov = "NORMAL",
    noV = "NORMAL",
    ["no\22"] = "NORMAL",
    niI = "NORMAL",
    niR = "NORMAL",
    niV = "NORMAL",
    nt = "NORMAL",
    v = "VISUAL",
    vs = "VISUAL",
    V = "VISUAL",
    Vs = "VISUAL",
    ["\22"] = "VISUAL",
    ["\22s"] = "VISUAL",
    s = "SELECT",
    S = "SELECT",
    ["\19"] = "SELECT",
    i = "INSERT",
    ic = "INSERT",
    ix = "INSERT",
    R = "REPL{ACE",
    Rc = "REPLACE",
    Rx = "REPLACE",
    Rv = "REPLACE",
    Rvc = "REPLACE",
    Rvx = "REPLACE",
    c = "COMMAND",
    cv = "COMMAND",
    r = "NORMAL",
    rm = "NORMAL",
    ["r?"] = "NORMAL",
    ["!"] = "NORMAL",
    t = "TERMINAL",
}
local mode_colors = {
    N = "red",
    I = "peach",
    S = "sapphire",
    V = "sapphire",
    R = "sapphire",
    C = "mauve",
    T = "green"
}
local mode_color = function()
    local mode = conditions.is_active() and vim.fn.mode() or "n"
    return mode_colors[mode_names[mode]:sub(1, 1)]
end

local VIMode = {
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    provider = function(self)
        return " %8(" .. mode_names[self.mode] .. "%)"
    end,
    hl = function()
        return { fg = mode_color(), bold = true }
    end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
    },
}

local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}
-- We can now define some children separately and add them later

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { bg = self.icon_color }
    end
}

local FileName = {
    provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return " [No Name]" end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return " " .. filename
    end,
    hl = { fg = utils.get_highlight("Directory").fg },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = "[+]",
        hl = { fg = "green" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = "red" },
    },
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = "cyan", bold = true, force = true }
        end
    end,
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
    OpenLogo,
    FileIcon,
    LogoSlant,
    utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    FileFlags,
    { provider = '%<' }                      -- this means that the statusline is cut here when there's not enough space
)

local Ruler = {
    provider = "%7(%l/%3L%) %P",
    hl = { bg = "dark" }
}

local Diagnostics = {
    condition = conditions.has_diagnostics,
    static = {
        error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
        warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
        info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
        hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
    },
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    on_click = {
        callback = function()
            require("trouble").toggle({ mode = "document_diagnostics" })
        end,
        name = "Diagnostics"
    },

    update = { "DiagnosticChanged", "BufEnter" },
    {
        provider = "",
        hl = { fg = "dark" }
    },
    {
        provider = " ",
        hl = { bg = "dark" }
    },
    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = { fg = "red", bg = "dark" },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = { fg = "peach", bg = "dark" },
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = { fg = "mauve", bg = "dark" },
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = { fg = "blue", bg = "dark" },
    },
    {
        provider = "",
        hl = { fg = "dark" }
    },
}

local Git = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    hl = { fg = "mauve" },
    {
        provider = "",
        hl = { fg = "dark" }
    },
    {
        provider = " ",
        hl = { bg = "dark" }
    },
    {
      -- git branch name
        provider = function(self)
            return " " .. self.status_dict.head
        end,
        hl = { bold = true, bg = "dark" }
    },
    -- You could handle delimiters, icons and counts similar to Diagnostics
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = " ",
        hl = { bg = "dark" }
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count)
        end,
        hl = { fg = "green", bg = "dark" },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count)
        end,
        hl = { fg = "red", bg = "dark" },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("~" .. count)
        end,
        hl = { fg = "peach", bg = "dark" },
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = " ",
        hl = { bg = "dark" }
    },
    {
        provider = "",
        hl = { fg = "dark" }
    },
}

local options = {
    statusline = {
        -- LEFT
        utils.surround({ "", "" }, "dark", { VIMode }),
        utils.surround({ "", "" }, "bg", { Space }),
        utils.surround({ "", "" }, "dark", { flexible = 100, { FileNameBlock } }),
        { flexible = 50,                               { utils.surround({ "", "" }, "bg", { Space }),
            utils.surround({ "", "" }, "dark", { Ruler }) } },
        Align,
        -- RIGHT
        { utils.surround({ "", "" }, "bg", { Space }), Diagnostics },
        Git,
    }
}

return options
