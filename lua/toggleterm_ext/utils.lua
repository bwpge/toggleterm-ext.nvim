local M = {}

---@param list string[]
---@param reverse boolean?
---@return string[]
function M.make_entries(list, reverse)
    local entries = {}
    for i, item in ipairs(list) do
        if reverse then
            table.insert(entries, 1, {
                idx = #list - i + 1,
                value = item,
            })
        else
            table.insert(entries, {
                idx = i,
                value = item,
            })
        end
    end

    return entries
end

---@param entry table
---@return table
function M.numbered_entry_maker(entry)
    local s = string.format("%s: %s", entry.idx, entry.value)
    return {
        value = entry.value,
        display = s,
        ordinal = s,
    }
end

---@param bufnr number
---@param cb fun(s:string)
---@return function
function M.select_string_action(bufnr, cb)
    local actions = require("telescope.actions")
    local state = require("telescope.actions.state")

    return actions.select_default:replace(function()
        actions.close(bufnr)
        local selection = state.get_selected_entry()
        if not selection then
            return
        end

        -- allow telescope to close the window before using the callback
        local wrap_cb = vim.schedule_wrap(cb)
        wrap_cb(selection.value)
    end)
end

return M
