local M = {}

M.last_input = ""
M.history = {}

---Pushes a value onto the history list. If the history already contains the
---value, it is removed before adding back to the end of the list.
---
---The value in the list is the most recent.
---@param value string
---@param max_count integer
function M.push_history(value, max_count)
    M.last_input = value

    -- TODO: we could be more clever about this and use a set table like
    -- { ["value"] = index } and then just shift around the indices. it would
    -- make popping easy as setting ["value"] = nil and avoid a bunch of
    -- copying, but that makes creating telescope entries a bit more difficult
    for i, entry in ipairs(M.history) do
        if entry == value then
            table.remove(M.history, i)
            break
        end
    end
    if max_count > 0 then
        while #M.history >= max_count do
            table.remove(M.history, 1)
        end
    end

    table.insert(M.history, value)
end

return M
