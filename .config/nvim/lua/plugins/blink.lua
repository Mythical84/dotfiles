return {
	{
		'saghen/blink.cmp',
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
					auto_show = false
				},
			},
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { 'sources.default' }
	},
}

