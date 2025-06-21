return {
	{
		'neovim/nvim-lspconfig', --premade configs for neovim native lsp
		dependencies = {
			'saghen/blink.cmp',
		},
		-- no need to actually load the plugin, since we only want the configs, instead add said configs to the runtime path
		lazy = true,
		init = function()
			local lspConfigPath = require("lazy.core.config").options.root .. "/nvim-lspconfig"
			vim.opt.runtimepath:prepend(lspConfigPath)
		end,
		config = function()
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			require('lspconfig').lua_ls.setup {capabilities = capabilities}
		end,
		event='LspAttach'
	}
}

