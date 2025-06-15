return {
	{
		'nvim-treesitter/nvim-treesitter',
		build=':TSUpdate',
		lazy=false,
		branch='master',
		config = function()
			require('nvim-treesitter').setup {
				ensure_installed = { 'python', 'rust', 'typescript', 'javascript', 'html', 'css', 'svelte' },
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true
				}
			}
		end
	}
}
