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
					["?"] = "toggle-preview",
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
				fzf = {
					["ctrl-a"] = "toggle-all",
				},
			},
			actions = {
				files = {
					["enter"] = actions.file_edit,
					["ctrl-s"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-t"] = actions.file_tabedit,
					["ctrl-q"] = actions.file_edit_or_qf,
					["ctrl-o"] = actions.toggle_ignore,
					["ctrl-h"] = actions.toggle_hidden,
					["ctrl-l"] = actions.toggle_follow,
				},
				grep = {
					["ctrl-g"] = actions.grep_lgrep,
				},
			},
		})

		local opts = { noremap = true, silent = true }

		-- Keybinds
		vim.keymap.set("n", "<Leader>F", "<Cmd>FzfLua<CR>", opts)

		vim.keymap.set("n", "<Leader>f", function()
			if vim.fn.len(vim.fn.system("git rev-parse")) == 0 then
				fzf_lua.git_files()
			else
				fzf_lua.files()
			end
		end, opts)

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
