return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require('luasnip').config.setup({
				enable_autosnippets=true,
				update_events = "TextChangedI",
				history=true
			})

			local ls = require("luasnip")

			vim.api.nvim_create_autocmd('FileType', {
				pattern = { 'markdown' },
				callback = function ()
					vim.keymap.set({ "i", "s" }, "<Tab>", function()
						if ls.expand_or_jumpable() then
							ls.expand_or_jump()
						else
							vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
						end
					end, { silent = true })

					vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
						if ls.jumpable(-1) then
							ls.jump(-1)
						else
							vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", true)
						end
					end, { silent = true })
				end
			})
		end
	}
}
