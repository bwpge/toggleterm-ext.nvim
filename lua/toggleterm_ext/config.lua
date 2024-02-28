local M = {}

---@alias BorderStyle "double" | "none" | "rounded" | "shadow" | "single" | "solid"
---@alias TextAlign "left" | "right" | "center"
---@alias Relative "cursor" | "editor" | "win" | table

---@class InputOptions
---@field border_style BorderStyle
---@field position string | number
---@field prompt string
---@field relative Relative
---@field title string
---@field title_align TextAlign
---@field width string | number

---@class Config
---@field expand_cmd boolean
---@field use_last_input boolean
---@field max_history integer
---@field input InputOptions

---@type Config
---@diagnostic disable-next-line: missing-fields
M._ = {}

---@return Config
function M.default_config()
    ---@type Config
    return {
        expand_cmd = false,
        use_last_input = true,
        max_history = 10,
        input = {
            border_style = "rounded",
            position = "50%",
            prompt = "> ",
            relative = "editor",
            title = "Launch ToggleTerm",
            title_align = "center",
            width = 0.3,
        },
    }
end

---@param opts table?
function M.set(opts)
    M._ = vim.tbl_deep_extend("force", M.default_config(), opts or {})
end

return M
