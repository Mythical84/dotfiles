require('setup.lazy')

require('lazy').setup({
	spec = {
		'neovim/nvim-lspconfig', --premade configs for neovim native lsp
		'hrsh7th/nvim-cmp', --neovim native lsp autocomplete
		'hrsh7th/cmp-buffer', --lsp autocomplete required library
		'hrsh7th/cmp-path', --lsp autocomplete required library 
		'hrsh7th/cmp-nvim-lsp', --lsp autocomplete required library 
		'petertriho/cmp-git', --Compatibility layer for git and autocomplete
		'nvim-lua/plenary.nvim', --Required to get autocomplete to work, no clue why
		{
				"rachartier/tiny-inline-diagnostic.nvim",
				event = "VeryLazy", -- Or `LspAttach`
				priority = 1000, -- needs to be loaded in first
				config = function()
						require('tiny-inline-diagnostic').setup()
						vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
				end
		}	
	}
})

---------- LSP ----------
vim.lsp.enable('rust_analyzer')
local cmp = require('cmp')
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<TAB>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-TAB>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
      end
		end, { 'i', 's' }),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name='nvim_lsp' }
	}, {
		{ name='buffer' },
	})
})
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' },
	}, {
		{ name = 'buffer' },
	})
})
require("cmp_git").setup()
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['rust_analyzer'].setup {
	capabilities = capabilities
}

---------- Variables ----------
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false
