local M = {}
local conf = {
    labels = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",";"},
    color="#ff0000",
    mappings={
        "<leader>f", "<leader>F"
    }
}

local function findInstancesAndReplace(buf_num, ns_id, match_char, is_forward)
    -- dictionary of index_char: {row_num, col_num}
    local num_matches = 0
    local char_match_idx = {}

    -- grab the current cursor location
    local cursor_row_num, cursor_col_num = vim.fn.line("."), vim.fn.col(".")

    -- loop through each row in the buffer
    local row_num = cursor_row_num
    local col_num = cursor_col_num
    while (1 <= row_num) and (row_num <= vim.fn.line("w$")) do
        -- get the content of the row
        local offset = 0
        local row_content = vim.fn.getline(row_num)

        -- if we are on the current line, only get from the current cursor position
        if row_num == cursor_row_num then
            if is_forward then
                row_content = string.sub(row_content, cursor_col_num+1, -1)
                offset = cursor_col_num
            else
                row_content = string.sub(row_content, 1, cursor_col_num-1)
            end
        end

        -- start from either end depending on forward or backwards
        col_num = is_forward and 1 or #row_content

        -- find all instances of our character in the current sentence
        while (1 <= col_num) and (col_num <= #row_content) do
            local char = string.sub(row_content, col_num, col_num)

            -- if match, add the match to our list, and overlay the character with the index
            if char == match_char then
                -- increment that we found a new match
                num_matches = num_matches + 1

                -- the character index for this match
                local char_idx = conf.labels[math.min(num_matches, #conf.labels)]

                -- record the char index
                if num_matches <= #conf.labels then
                    char_match_idx[char_idx] = {row_num, col_num+offset}
                end

                -- create the virtual text
                local opts = {
                    virt_text = {{char_idx, "betterFHighlightGroup"}},
                    virt_text_pos = "overlay",
                }
                vim.api.nvim_buf_set_extmark(buf_num, ns_id, row_num-1, col_num+offset-1, opts)
            end
            -- increment the col number
            col_num = is_forward and (col_num + 1) or (col_num - 1)
        end
        -- increment row number
        row_num = is_forward and (row_num + 1) or (row_num - 1)
    end

    return char_match_idx
end

local function betterF(is_forward)
    local match_value = vim.fn.getchar()
    if match_value == 27 then
        return
    end

    -- metadata for the search: the matched character, current buffer number and namespace for virtual text
    local match_char = vim.fn.nr2char(match_value)
    local buf_num = vim.fn.bufnr()
    local ns_id = vim.api.nvim_create_namespace("betterF")

    -- keep finding until we complete
    local complete = false
    while not complete do
        -- get all matches, this is a dictionary of index_char: {row_num, col_num}
        local index_char_match = findInstancesAndReplace(buf_num, ns_id, match_char, is_forward)

        -- redraw
        vim.cmd("redraw!")

        -- get the user's requested jump location
        local jump_value = vim.fn.getchar()
        local jump_char = vim.fn.nr2char(jump_value)
        complete = true

        -- if it's not escape and the character exists in the matches, jump to the location
        if jump_value ~= 27 and index_char_match[jump_char] then
            local jump_location = index_char_match[jump_char]
            vim.api.nvim_win_set_cursor({0}, {jump_location[1], jump_location[2]-1})

            -- if it's the last character, exit, otherwise we need to repeat the loop
            if jump_char == conf.labels[#conf.labels] then
                complete = false
            end
        end

        -- clear the highlights, redraw
        vim.api.nvim_buf_clear_namespace(buf_num, ns_id, 0, -1)
        vim.cmd("redraw!")
    end
end

function M.setup(opts)
    -- config
    conf = vim.tbl_deep_extend("keep", conf, opts or {})

    -- highlight group for colors
    vim.api.nvim_command("highlight betterFHighlightGroup guifg="..conf.color)

    -- keymaps
    vim.keymap_set('n', conf.mappings[1], function() betterF(true) end, { noremap = true, silent = true })
    vim.keymap_set('n', conf.mappings[2], function() betterF(false) end, { noremap = true, silent = true })
end

return M
