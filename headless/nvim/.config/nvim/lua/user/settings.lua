-- Add option to Vim's default diffopts
vim.opt.diffopt:append("linematch:50")

-- Make substituitions show a preview window
vim.opt.inccommand = "split"
