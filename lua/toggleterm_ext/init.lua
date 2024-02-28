local config = require("toggleterm_ext.config")
local ui = require("toggleterm_ext.ui")

local M = {}

M.is_loaded = false

local hl_groups = {
    Border = "TelescopePromptBorder",
    Normal = "TelescopeNormal",
    Prompt = "TelescopePromptPrefix",
    Title = "TelescopePromptTitle",
}

---Configures this plugin with user options.
---@param opts table?
function M.setup(opts)
    if M.is_loaded then
        return
    end

    M.is_loaded = true
    config.set(opts)

    for k, v in pairs(hl_groups) do
        local group = "ToggleTermLauncher" .. k
        if vim.fn.hlexists(group) == 0 then
            vim.api.nvim_set_hl(0, group, { link = v })
        end
    end

    vim.api.nvim_create_user_command("TermExecInput", function()
        ui.input():mount()
    end, {})
end

return M
