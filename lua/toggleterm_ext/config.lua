local M = {}

---@alias BorderStyle "double" | "none" | "rounded" | "shadow" | "single" | "solid"
---@alias TextAlign "left" | "right" | "center"
---@alias Size string | number

---@class InputOptions
---@field border_style BorderStyle
---@field title string
---@field title_align TextAlign
---@field prompt string
---@field width Size

---@class Config
---@field expand_cmd boolean
---@field use_last_input boolean
---@field max_history integer
---@field input InputOptions

---@type Config
---@diagnostic disable-next-line: missing-fields
M._ = {}

---@return Config
---@private
function M.default_config()
    ---@type Config
    return {
        expand_cmd = false,
        use_last_input = true,
        max_history = 10,
        input = {
            border_style = "rounded",
            prompt = "> ",
            title = "Launch ToggleTerm",
            title_align = "center",
            width = 0.333,
        },
    }
end

---@param opts table?
function M.set(opts)
    M._ = vim.tbl_deep_extend("force", M.default_config(), opts or {})
end

return M
