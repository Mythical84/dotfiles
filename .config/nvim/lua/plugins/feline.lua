return {
	{
		'Famiu/feline.nvim',
		config = function ()
			vim.opt.termguicolors = true
			require('feline').setup()
		end
	}
}
