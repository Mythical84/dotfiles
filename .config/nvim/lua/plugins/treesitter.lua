return {
	{
		'nvim-treesitter/nvim-treesitter',
		build=':TSUpdate',
		lazy=false,
		branch='main',
		config = function()
			require('nvim-treesitter').setup {
			}
		end
	}
}
