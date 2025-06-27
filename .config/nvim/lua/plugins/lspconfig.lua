return {
	{
		'neovim/nvim-lspconfig', --premade configs for neovim native lsp
		dependencies = {
			'saghen/blink.cmp',
		},
		lazy = true,
		init = function()
			local lspConfigPath = require("lazy.core.config").options.root .. "/nvim-lspconfig"
			vim.opt.runtimepath:prepend(lspConfigPath)
		end,
		config = function()
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			require('lspconfig').lua_ls.setup {capabilities = capabilities}
			vim.keymap.set('i', '<Tab>', function()
				-- Get current line content
				local line = vim.api.nvim_get_current_line()

				if line == "" then
					return vim.api.nvim_replace_termcodes("<Esc>ddk$a<cr>", true, false, true)
				else
					return vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
				end
			end, { expr = true, silent = true })
		end,
		event='LspAttach'
	}
}

