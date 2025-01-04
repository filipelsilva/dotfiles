return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"giuxtaposition/blink-cmp-copilot",
	},

	version = "*",

	opts = {
		keymap = {
			preset = "default",
			["<C-y>"] = { "select_and_accept", "fallback" },
			["<CR>"] = { "select_and_accept", "fallback" },
			["<C-n>"] = { "snippet_forward", "select_next", "fallback" },
			["<C-p>"] = { "snippet_backward", "select_prev", "fallback" },
			["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-e>"] = { "show", "hide" },
		},

		appearance = {
			nerd_font_variant = "normal",
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "copilot" },
			cmdline = {},
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
				},
			},
		},

		completion = {
			keyword = { range = "full" },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
		},

		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
