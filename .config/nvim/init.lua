-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require('lazy').setup({
	spec = {
		{ import='plugins' }
	},
	change_detection = {
		notify = false
	},
})

---------- LSP ----------
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('svelte')
vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')

---------- Variables ----------
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false

-- Colorscheme
vim.cmd.colorscheme('onedark')
vim.cmd('highlight LineNr ctermfg=grey')

require("vim.treesitter.query").set(
  "svelte",
  "injections",
  [[
  (
    element
      (start_tag
        (attribute
          (attribute_name) @_attr_name (#eq? @_attr_name "lang")
          (quoted_attribute_value (attribute_value) @_attr_value (#match? @_attr_value "ts"))
        )
      )
      (raw_text) @typescript
  )
  ]]
)
