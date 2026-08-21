-- Add option to Vim's default diffopts
vim.opt.diffopt:append("linematch:50")

-- Make substituitions show a preview window
vim.opt.inccommand = "split"

-- Add undotree plugin (command :Undotree)
vim.cmd("packadd nvim.undotree")

-- Add difftool plugin (command :DiffTool)
vim.cmd("packadd nvim.difftool")
