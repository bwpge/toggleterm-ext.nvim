local state = require("toggleterm_ext.state")
local ui = require("toggleterm_ext.ui")
local utils = require("toggleterm_ext.utils")

---@param entries table
---@param cb fun(s:string)
---@param _ table?
---@return table
local function make_picker(entries, cb, _)
    local finders = require("telescope.finders")
    local themes = require("telescope.themes")
    local conf = require("telescope.config").values

    return require("telescope.pickers").new(themes.get_dropdown(), {
        prompt_title = "Launch History",
        finder = finders.new_table({
            results = entries,
            entry_maker = utils.numbered_entry_maker,
        }),
        previewer = false,
        sorter = conf.generic_sorter(),
        attach_mappings = function(bufnr, _)
            utils.select_string_action(bufnr, cb)
            return true
        end,
    })
end

---@param opts table Options table passed in by telescope
local function history_picker(opts)
    local history = state.history
    if #history < 1 then
        vim.notify("No launcher history to show")
        return
    end

    local entries = utils.make_entries(history, true)
    make_picker(entries, ui.on_select, opts):find()
end

return require("telescope").register_extension({
    setup = function(_, _) end,
    exports = {
        toggleterm_ext = history_picker,
    },
})
