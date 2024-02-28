local config = require("toggleterm_ext.config")
local state = require("toggleterm_ext.state")

local toggleterm = require("toggleterm")
local NuiInput = require("nui.input")
local NuiText = require("nui.text")

local M = {}

---@private
function M.on_select(value)
    -- ignore only nil/whitespace values
    if not value or value:match("^%s*$") then
        return
    end
    state.push_history(value, config._.max_history)

    local cmd = value
    if config._.expand_cmd then
        cmd = vim.fn.expandcmd(value)
    end
    toggleterm.exec(cmd)
end

---@return table
function M.input()
    local conf = config._

    local default_value = ""
    if conf.use_last_input then
        default_value = state.last_input
    end
    local popup = NuiInput({
        relative = "editor",
        position = "50%",
        size = {
            width = conf.input.width,
        },
        border = {
            style = conf.input.border_style,
            text = {
                top = " " .. conf.input.title .. " ",
                top_align = conf.input.title_align,
            },
        },
        win_options = {
            winhighlight = "Normal:ToggleTermLauncherNormal,Title:ToggleTermLauncherTitle,FloatBorder:ToggleTermLauncherBorder",
        },
        buf_options = {
            bufhidden = "delete",
            buflisted = false,
            filetype = "toggleterm-ext-input",
        },
    }, {
        prompt = NuiText(conf.input.prompt, "ToggleTermLauncherPrompt"),
        default_value = default_value,
        on_submit = function(value)
            M.on_select(value)
        end,
    })

    -- unmount by pressing `<esc>`
    popup:map("n", "<Esc>", function()
        popup:unmount()
    end, { noremap = true })
    popup:map("i", "<Esc>", function()
        popup:unmount()
    end, { noremap = true })

    local event = require("nui.utils.autocmd").event
    popup:on(event.BufLeave, function()
        popup:unmount()
    end)

    return popup
end

return M
