return {
	{
	  'nvim-treesitter/nvim-treesitter',
		lazy = false,
		branch = 'main',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter').setup {
				indent = {
					enable = true,
				},
				highlight = {
					enable = true,
				},
			}
		end
	}
}
