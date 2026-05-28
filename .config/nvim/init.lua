vim.cmd("source ~/.vimrc")

require("octo").setup({
  picker = "fzf-lua", -- or "telescope" or "snacks" or "default"
  picker_config = {
    use_emojis = true, -- only used by "fzf-lua" picker for now
    search_static = true, -- Whether to use static search results (true) or dynamic search (false)
  },
  default_remote = { "origin" }, -- order to try remotes
  default_delete_branch = true, -- whether to delete branch when merging pull request with either `Octo pr merge` or from picker (can be overridden with `delete`/`nodelete` argument to `Octo pr merge`)
  mappings = {
    pull_request = {
      add_comment = { lhs = "<C-c>", desc = "add comment" },
      add_reply = { lhs = "<C-r>", desc = "add reply" },
    },
    review_thread = {
      add_comment = { lhs = "<C-c>", desc = "add comment" },
      add_reply = { lhs = "<C-r>", desc = "add reply" },
    },
    review_diff = {
      add_review_comment = { lhs = "<C-c>", desc = "add a new review comment", mode = { "n", "x" } },
    },
    notification = {
      read = { lhs = "<C-m>", desc = "mark notification as read" },
      done = { lhs = "<C-d>", desc = "mark notification as done" },
      unsubscribe = { lhs = "<C-u>", desc = "unsubscribe from notifications" },
    },
  },
  poll = {
    enabled = true,            -- opt-in polling for remote changes
    interval = 15000,          -- polling interval in milliseconds (default: 10s)
    notify_on_refresh = false, -- notify when a buffer is auto-refreshed
    notify_on_change = true,   -- notify when remote changed but buffer has local edits
  },
})
