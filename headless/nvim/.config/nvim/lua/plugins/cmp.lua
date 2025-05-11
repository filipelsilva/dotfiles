return {
	"saghen/blink.cmp",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
		"rafamadriz/friendly-snippets",
	},
	version = "*",
	opts = {
		keymap = {
			preset = "none",
			["<C-y>"] = { "select_and_accept", "fallback" },
			["<CR>"] = { "select_and_accept", "fallback" },
			["<C-n>"] = { "select_next", "snippet_forward", "fallback" },
			["<C-p>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-e>"] = { "show", "hide" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
		},
		cmdline = {
			enabled = false,
		},
		term = {
			enabled = false,
		},
		sources = {
			default = {
				"avante",
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
					opts = {},
				},
			},
		},
		completion = {
			keyword = { range = "full" },
			menu = {
				border = "none",
				draw = {
					columns = {
						{ "label" },
						{ "kind" },
						{ "label_description", gap = 1 },
					},
				},
			},
			documentation = { auto_show = true },
		},
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
