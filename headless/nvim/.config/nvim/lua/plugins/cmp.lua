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
			["<C-n>"] = { "select_next", "snippet_forward", "fallback" },
			["<C-p>"] = { "select_prev", "snippet_backward", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
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
				"lsp",
				"path",
				"snippets",
				"buffer",
				"copilot",
			},
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
					transform_items = function(_, items)
						local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
						local kind_idx = #CompletionItemKind + 1
						CompletionItemKind[kind_idx] = "Copilot"
						for _, item in ipairs(items) do
							item.kind = kind_idx
						end
						return items
					end,
				},
			},
		},
		completion = {
			keyword = { range = "full" },
			menu = {
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
