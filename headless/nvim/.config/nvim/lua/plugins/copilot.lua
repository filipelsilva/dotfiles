return {
	"zbirenbaum/copilot.lua",
	config = function()
		local ok_copilot, copilot = pcall(require, "copilot")

		if not ok_copilot then
			return
		end

		copilot.setup({
			suggestion = { enabled = false },
			panel = { enabled = false },
		})
	end
}
