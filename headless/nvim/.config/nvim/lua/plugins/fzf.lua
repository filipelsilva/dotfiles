return {
	"ibhagwan/fzf-lua",
	dependencies = {
		{
			"junegunn/fzf",
			build = ":call fzf#install()",
		},
	},
	config = function()
		local ok_fzf_lua, fzf_lua = pcall(require, "fzf-lua")
		if not ok_fzf_lua then
			return
		end

		local _, actions = pcall(require, "fzf-lua.actions")

		fzf_lua.setup({
			file_icons = false,
			fzf_colors = true,
			winopts = {
				width = 0.80,
				height = 0.90,
				backdrop = 100,
				preview = {
					horizontal = "right:50%",
					vertical = "up:50%",
				},
			},
			keymap = {
				builtin = {
					true,
					["?"] = "toggle-preview",
					["ctrl-a"] = "select-all",
				},
			},
			actions = {
				files = {
					true,
					["ctrl-q"] = actions.file_edit_or_qf,
				},
			},
			grep = {
				rg_opts = "--hidden --iglob '!*.git' --iglob '!*.hg' --iglob '!*.svn' --iglob '!*CVS' "
					.. fzf_lua.defaults.grep.rg_opts,
			},
		})

		local opts = { noremap = true, silent = true }

		-- Keybinds
		vim.keymap.set("n", "<Leader>f", fzf_lua.files, opts)

		vim.keymap.set("n", "<Leader>r", fzf_lua.live_grep, opts)
		vim.keymap.set("n", "<Leader>q", fzf_lua.grep_cword, opts)
		vim.keymap.set("n", "<Leader>Q", fzf_lua.grep_cWORD, opts)
		vim.keymap.set("v", "<Leader>q", fzf_lua.grep_visual, opts)

		vim.keymap.set("n", "<Leader>o", fzf_lua.oldfiles, opts)

		vim.keymap.set("n", "<Leader>j", fzf_lua.buffers, opts)

		-- Edit nvim configuration files
		vim.keymap.set("n", "<Leader><Leader>v", function()
			fzf_lua.files({
				cwd = "$HOME/.config/nvim",
			})
		end, opts)

		-- Edit vim configuration file
		vim.keymap.set("n", "<Leader>v", "<Cmd>edit $HOME/.vim/vimrc<CR>", opts)
	end,
}
