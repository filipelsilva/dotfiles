
-- Fix for the client offset_encodings error
-- This is not a good fix, but for now it's the best one
local notify = vim.notify
vim.notify = function(msg, ...)
	if msg:match("warning: multiple different client offset_encodings") then
		return
	end

	notify(msg, ...)
end
