return {
	{
		'obsidian-nvim/obsidian.nvim',
		version='*',
		lazy=true,
		ft='markdown',
		event = {
			'BufReadPre /home/tyler/school-notes/*.md',
			'BufNewFile /home/tyler/school-notes/*.md'
		},
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		opts = {
			workspaces = {
				{
					name='school',
					path = '~/school-notes'
				}
			},
			completion = {
				blink = true,
				nvim_cmp = false,
			},
			picker = {
				name = 'telescope.nvim'
			}
		}
	}
}
