return {
	{
		'saghen/blink.cmp',
		dependencies = {
			"xzbdmw/colorful-menu.nvim",
			'L3MON4D3/LuaSnip'
		},
		build = "cargo +nightly build --release",
		opts = {
			keymap = {
				preset = 'enter',
				['<TAB>'] = { 'select_next', 'fallback' },
				['<S-TAB>'] = { 'select_prev', 'fallback' },
			},
			appearance = {
				nerd_font_variant='mono'
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0
				},
				list = {
					selection = {
						preselect = true,
						auto_insert = false
					}
				},
				accept = {
					auto_brackets = {
						enabled = false
					}
				},
				menu = {
					draw = {
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							}
						}
					}
				},
				ghost_text = {
					enabled = true,
				},
			},
			signature = {
				enabled = true,
				trigger = {
					show_on_insert = true,
				}
			},
			snippets = { preset = 'luasnip' },
			sources = {
				default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
				providers = {
					lazydev = {
						name='LazyDev',
						module='lazydev.integrations.blink',
						score_offset = 100
					}
				}
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { 'sources.default' },
		event='LspAttach'
	}
}
