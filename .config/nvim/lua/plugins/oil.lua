return {
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		lazy = false,
		config = function()
			require('oil').setup {
				default_file_explorer = true,
				columns = {
					"icon",
					"size"
				},
				win_options = {
					wrap = true,
				},
				skip_confirm_for_simple_edits = true
			}
		end
	}
}
