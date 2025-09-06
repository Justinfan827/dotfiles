local M = {}

local diff = require("mini.diff")
--
-- Approach for tab completion similar to cursor
--
-- Approach 1:
--
-- 1. Take the current buffer.
-- 2. Take the changes that have been made to the buffer.
-- 3. Estimate the end state of buffer based on in-progress changes (ask AI).
-- 4. Calculate the diff between current buffer and end state.
-- 5. Display the diff sites when the cursor lands in the diff area.
-- 6. Tab will move you between the diff sites.
--
-- Should be pretty simple, right? Leverage 'diff' feature of nvim?
--
-- Approach 2:
--
-- Same approach here, except that diff sites 'show up' under the cursor.
--
--

M.setup = function()
	-- nothing yet
end

---@class present.Slides
---@fields slides string[]: The slides of the file

--- Takes some markdown lines and parse them into slides
---@param lines string[]
---@return present.Slides
local parse_slides = function(lines)
	local slidesContainer = { slides = {} }
	local currentSlide = {}
	local separator = "^#"
	for _, line in ipairs(lines) do
		-- insert a new slide when we see #
		if line:find(separator) then
			if #currentSlide > 0 then
				table.insert(slidesContainer.slides, currentSlide)
			end
			currentSlide = {}
		end
		table.insert(currentSlide, line)
	end
	table.insert(slidesContainer.slides, currentSlide)
	return slidesContainer
end

local ns_completor = "completor.lua"
local mark_ns = -1
local extMarks = {}

local show_virtual_text = function()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	mark_ns = vim.api.nvim_create_namespace(ns_completor)
	local current_line = cursor_pos[1] - 1
	local hl_for_virt = "Conceal"
	local mark_id = vim.api.nvim_buf_set_extmark(0, mark_ns, current_line, -1, {
		hl_mode = "combine",
		virt_text = {
			{ "this is virtual text 2", { hl_for_virt } },
		},
		virt_lines = {
			{ { "this is a virtual line 1", { hl_for_virt } } },
			{ { "this is virtual line 2 ", { hl_for_virt } } },
		},
		virt_text_pos = "overlay",
	})
	table.insert(extMarks, mark_id)
end

local delete_virtual_text = function()
	for _, mark_id in ipairs(extMarks) do
		vim.api.nvim_buf_del_extmark(0, mark_ns, mark_id)
	end
end

local set_reference_text = function()
	diff.set_ref_text(0, "export type Json =\nwow\nwow")
	diff.toggle_overlay(0)
end

-- testing this out
-- vim.print(parse_slides({ "# Hello", "This is something else", "# Second slide" }))

M.show_virtual_text = function()
	show_virtual_text()
end

M.delete_virtual_text = function()
	delete_virtual_text()
end

M.set_reference_text = function()
	set_reference_text()
end
return M
