-- Disable vim plugins defined in vimrc
vim.g.no_vim_plugins = 1

-- Default vim config
vim.cmd("source $HOME/.vimrc")

require("user.cmp")
require("user.colorscheme")
require("user.comment")
require("user.lsp")
require("user.plugins")
require("user.telescope")
require("user.treesitter")
