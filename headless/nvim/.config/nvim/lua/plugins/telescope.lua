return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make"
		}
	},
	config = function()
		local ok_telescope, telescope = pcall(require, "telescope")
		local ok_actions, actions = pcall(require, "telescope.actions")
		local ok_builtin, telescope_builtin = pcall(require, "telescope.builtin")

		if not ok_telescope or not ok_actions or not ok_builtin then
			return
		end

		telescope.setup({
			defaults = {
				sorting_strategy = "ascending",
				layout_strategy = "flex",
				layout_config = {
					prompt_position = "top",
					width = 0.80,
					height = 0.90,
				},
				path_display = {
					"smart",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-s>"] = actions.select_horizontal,
						["<C-x>"] = false,
						["<C-a>"] = actions.select_all,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
					n = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-s>"] = actions.select_horizontal,
						["<C-x>"] = false,
						["<C-a>"] = actions.select_all,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
				vimgrep_arguments = {
					"rg",
					"--hidden",
					"--vimgrep",
					"--no-heading",
					"--smart-case",
				},
			},
		})

		telescope.load_extension("fzf")

		local opts = { noremap = true, silent = true }

		-- Telescope
		vim.keymap.set("n", "<Leader>f", function()
			if vim.fn.len(vim.fn.system("git rev-parse")) == 0 then
				telescope_builtin.git_files({
					hidden = true,
					show_untracked = true
				})
			else
				local is_home = os.getenv("HOME") == os.getenv("PWD")
				telescope_builtin.find_files({
					hidden = not is_home
				})
			end
		end, opts)

		vim.keymap.set("n", "<Leader>r", function()
			telescope_builtin.live_grep({
				glob_pattern = { "!*.git", "!*.hg", "!*.svn", "!*CVS" }
			})
		end, opts)

		vim.keymap.set("n", "<Leader>o", telescope_builtin.oldfiles, opts)

		vim.keymap.set("n", "<Leader>j", telescope_builtin.buffers, opts)

		-- Edit nvim configuration files
		vim.keymap.set("n", "<Leader><Leader>v", function()
			telescope_builtin.find_files({
				cwd = "$HOME/.config/nvim",
				search_dirs = {
					"$HOME/.config/nvim/init.lua",
					"$HOME/.config/nvim/lua",
					"$HOME/.config/nvim/after"
				},
				hidden = true,
				follow = true
			})
		end, opts)

		-- Edit vim configuration file
		vim.keymap.set("n", "<Leader>v", "<Cmd>edit $HOME/.vim/vimrc<CR>", opts)
	end
}
