local M = {}

M.last_input = ""
M.history = {}

---Pushes a value onto the history list. If the history already contains the
---value, it is removed before adding back to the end of the list.
---
---The last value in the list is the most recent.
---@param value string
---@param max_count integer
function M.push_history(value, max_count)
    M.last_input = value

    -- push newest item to the front
    M.history[value] = 1

    -- shift all other indices up by 1
    for k, i in pairs(M.history) do
        local idx = i + 1
        if k ~= value then
            if idx > max_count then
                M.history[k] = nil
            else
                M.history[k] = idx
            end
        end
    end
end

---Returns a list history entries for use by a telescope picker.
---@return table
function M.history_entries()
    local entries = {}
    for k, i in pairs(M.history) do
        entries[i] = {
            idx = i,
            value = k,
        }
    end
    return entries
end

return M
