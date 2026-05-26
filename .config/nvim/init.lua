vim.cmd("source ~/.vimrc")

require("octo").setup({
  picker = "fzf-lua", -- or "telescope" or "snacks" or "default"
  picker_config = {
    use_emojis = true, -- only used by "fzf-lua" picker for now
    search_static = true, -- Whether to use static search results (true) or dynamic search (false)
  },
  default_remote = { "origin" }, -- order to try remotes
  default_delete_branch = true, -- whether to delete branch when merging pull request with either `Octo pr merge` or from picker (can be overridden with `delete`/`nodelete` argument to `Octo pr merge`)
})
