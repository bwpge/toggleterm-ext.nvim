local state = require("toggleterm_ext.state")
local ui = require("toggleterm_ext.ui")

local function telescope_picker(_)
    local history = state.history
    if #history < 1 then
        vim.notify("No toggleterm launcher history to show")
        return
    end

    -- create entries in reverse order
    local entries = {}
    for i, item in ipairs(history) do
        table.insert(entries, 1, {
            idx = #history - i + 1,
            value = item,
        })
    end

    local finders = require("telescope.finders")
    local actions = require("telescope.actions")
    local themes = require("telescope.themes")
    local tstate = require("telescope.actions.state")
    local conf = require("telescope.config").values

    require("telescope.pickers")
        .new(themes.get_dropdown(), {
            prompt_title = "Launch History",
            finder = finders.new_table({
                results = entries,
                entry_maker = function(entry)
                    local s = string.format("%d: %s", entry.idx, entry.value)
                    return {
                        value = entry.value,
                        display = s,
                        ordinal = s,
                    }
                end,
            }),
            previewer = false,
            sorter = conf.generic_sorter(),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = tstate.get_selected_entry()
                    if not selection then
                        return
                    end

                    -- FIXME: this selection part is odd. sometimes it is a
                    -- string and sometimes it is an entry (table)
                    if type(selection) == "string" then
                        ui.on_select(selection)
                    elseif type(selection) == "table" then
                        ui.on_select(selection.value)
                    end
                end)
                return true
            end,
        })
        :find()
end

return require("telescope").register_extension({
    setup = function(_, _) end,
    exports = {
        toggleterm_ext = telescope_picker,
    },
})
