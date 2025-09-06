local M = {}

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

-- testing this out
-- vim.print(parse_slides({ "# Hello", "This is something else", "# Second slide" }))

M.start_presentation = function() end
return M
