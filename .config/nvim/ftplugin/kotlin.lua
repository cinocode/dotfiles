vim.lsp.config('kotlin_lsp', {
  cmd = { "kotlin-lsp", "--stdio" },
  single_file_support = false
})
vim.lsp.enable('kotlin_lsp')
