vim.cmd("source ~/.vimrc")

require('telescope').setup()
require('telescope').load_extension('fzf')
require("telescope").load_extension("yadm_files")
require("telescope").load_extension("git_or_files")
require("telescope").load_extension("git_or_yadm_files")

local cmp = require'cmp'
cmp.setup {
	sources = {
		{ name = 'nvim_lsp' },
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	}),
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('nvim-treesitter').setup {
  opts = {
    ensure_installed = { 'bash', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'java' }
  },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
}

require("todoist").setup({
  api_key = vim.env.TODOIST_API_KEY
})

vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
callback = function()
require("nvim-treesitter.parsers").projects = {
 install_info = {
  path = vim.env.HOME .. "/.local/share/nvim/site/pack/bundle/start/tree-sitter-projects",
  files = { "src/parser.c" },
 },
 filetype = "projects",
}
end})

local actions = require("diffview.actions")

require("diffview").setup({
  diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = false, -- See |diffview-config-enhanced_diff_hl|
  git_cmd = { "git" },      -- The git executable followed by default args.
  hg_cmd = { "hg" },        -- The hg executable followed by default args.
  use_icons = true,         -- Requires nvim-web-devicons
  show_help_hints = true,   -- Show hints for how to open the help panel
  watch_index = true,       -- Update views and index buffers when the git index changes.
  icons = {                 -- Only applies when use_icons is true.
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
    done = "✓",
  },
  view = {
    -- Configure the layout and behavior of different types of views.
    -- Available layouts:
    --  'diff1_plain'
    --    |'diff2_horizontal'
    --    |'diff2_vertical'
    --    |'diff3_horizontal'
    --    |'diff3_vertical'
    --    |'diff3_mixed'
    --    |'diff4_mixed'
    -- For more info, see |diffview-config-view.x.layout|.
    default = {
      -- Config for changed files, and staged files in diff views.
      layout = "diff2_vertical",
      disable_diagnostics = false,  -- Temporarily disable diagnostics for diff buffers while in the view.
      winbar_info = false,          -- See |diffview-config-view.x.winbar_info|
    },
    merge_tool = {
      -- Config for conflicted files in diff views during a merge or rebase.
      layout = "diff3_vertical",
      disable_diagnostics = true,   -- Temporarily disable diagnostics for diff buffers while in the view.
      winbar_info = true,           -- See |diffview-config-view.x.winbar_info|
    },
    file_history = {
      -- Config for changed files in file history views.
      layout = "diff2_vertical",
      disable_diagnostics = false,  -- Temporarily disable diagnostics for diff buffers while in the view.
      winbar_info = false,          -- See |diffview-config-view.x.winbar_info|
    },
  },
  file_panel = {
    listing_style = "tree",             -- One of 'list' or 'tree'
    tree_options = {                    -- Only applies when listing_style is 'tree'
      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
    },
    win_config = {                      -- See |diffview-config-win_config|
      position = "left",
      width = 35,
      win_opts = {},
    },
  },
  file_history_panel = {
    log_options = {   -- See |diffview-config-log_options|
      git = {
        single_file = {
          diff_merges = "combined",
        },
        multi_file = {
          diff_merges = "first-parent",
        },
      },
      hg = {
        single_file = {},
        multi_file = {},
      },
    },
    win_config = {    -- See |diffview-config-win_config|
      position = "bottom",
      height = 16,
      win_opts = {},
    },
  },
  commit_log_panel = {
    win_config = {},  -- See |diffview-config-win_config|
  },
  default_args = {    -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {},         -- See |diffview-config-hooks|
  keymaps = {
    disable_defaults = false, -- Disable the default keymaps
    view = {
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      { "n", "<tab>",       actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",     actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
      { "n", "[F",          actions.select_first_entry,             { desc = "Open the diff for the first file" } },
      { "n", "]F",          actions.select_last_entry,              { desc = "Open the diff for the last file" } },
      { "n", "gf",          actions.goto_file_edit,                 { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",  actions.goto_file_split,                { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",     actions.goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",   actions.focus_files,                    { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",   actions.toggle_files,                   { desc = "Toggle the file panel." } },
      { "n", "g<C-x>",      actions.cycle_layout,                   { desc = "Cycle through available layouts." } },
      { "n", "[x",          actions.prev_conflict,                  { desc = "In the merge-tool: jump to the previous conflict" } },
      { "n", "]x",          actions.next_conflict,                  { desc = "In the merge-tool: jump to the next conflict" } },
      { "n", "<leader>co",  actions.conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
      { "n", "<leader>ct",  actions.conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
      { "n", "<leader>cb",  actions.conflict_choose("base"),        { desc = "Choose the BASE version of a conflict" } },
      { "n", "<leader>ca",  actions.conflict_choose("all"),         { desc = "Choose all the versions of a conflict" } },
      { "n", "dx",          actions.conflict_choose("none"),        { desc = "Delete the conflict region" } },
      { "n", "<leader>cO",  actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
      { "n", "<leader>cT",  actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
      { "n", "<leader>cB",  actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
      { "n", "<leader>cA",  actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
      { "n", "dX",          actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
    },
    diff1 = {
      -- Mappings in single window diff layouts
      { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
    },
    diff2 = {
      -- Mappings in 2-way diff layouts
      { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
    },
    diff3 = {
      -- Mappings in 3-way diff layouts
      { { "n", "x" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "g?",   actions.help({ "view", "diff3" }),  { desc = "Open the help panel" } },
    },
    diff4 = {
      -- Mappings in 4-way diff layouts
      { { "n", "x" }, "1do",  actions.diffget("base"),            { desc = "Obtain the diff hunk from the BASE version of the file" } },
      { { "n", "x" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "g?",   actions.help({ "view", "diff4" }),  { desc = "Open the help panel" } },
    },
    file_panel = {
      { "n", "j",              actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",         actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",              actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<up>",           actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<cr>",           actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "o",              actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "l",              actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "<2-LeftMouse>",  actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "-",              actions.toggle_stage_entry,             { desc = "Stage / unstage the selected entry" } },
      { "n", "s",              actions.toggle_stage_entry,             { desc = "Stage / unstage the selected entry" } },
      { "n", "S",              actions.stage_all,                      { desc = "Stage all entries" } },
      { "n", "U",              actions.unstage_all,                    { desc = "Unstage all entries" } },
      { "n", "X",              actions.restore_entry,                  { desc = "Restore entry to the state on the left side" } },
      { "n", "L",              actions.open_commit_log,                { desc = "Open the commit log panel" } },
      { "n", "zo",             actions.open_fold,                      { desc = "Expand fold" } },
      { "n", "h",              actions.close_fold,                     { desc = "Collapse fold" } },
      { "n", "zc",             actions.close_fold,                     { desc = "Collapse fold" } },
      { "n", "za",             actions.toggle_fold,                    { desc = "Toggle fold" } },
      { "n", "zR",             actions.open_all_folds,                 { desc = "Expand all folds" } },
      { "n", "zM",             actions.close_all_folds,                { desc = "Collapse all folds" } },
      { "n", "<c-b>",          actions.scroll_view(-0.25),             { desc = "Scroll the view up" } },
      { "n", "<c-f>",          actions.scroll_view(0.25),              { desc = "Scroll the view down" } },
      { "n", "<tab>",          actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",        actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
      { "n", "[F",             actions.select_first_entry,             { desc = "Open the diff for the first file" } },
      { "n", "]F",             actions.select_last_entry,              { desc = "Open the diff for the last file" } },
      { "n", "gf",             actions.goto_file_edit,                 { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",     actions.goto_file_split,                { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",        actions.goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
      { "n", "i",              actions.listing_style,                  { desc = "Toggle between 'list' and 'tree' views" } },
      { "n", "f",              actions.toggle_flatten_dirs,            { desc = "Flatten empty subdirectories in tree listing style" } },
      { "n", "R",              actions.refresh_files,                  { desc = "Update stats and entries in the file list" } },
      { "n", "<leader>e",      actions.focus_files,                    { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",      actions.toggle_files,                   { desc = "Toggle the file panel" } },
      { "n", "g<C-x>",         actions.cycle_layout,                   { desc = "Cycle available layouts" } },
      { "n", "[x",             actions.prev_conflict,                  { desc = "Go to the previous conflict" } },
      { "n", "]x",             actions.next_conflict,                  { desc = "Go to the next conflict" } },
      { "n", "g?",             actions.help("file_panel"),             { desc = "Open the help panel" } },
      { "n", "<leader>cO",     actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
      { "n", "<leader>cT",     actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
      { "n", "<leader>cB",     actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
      { "n", "<leader>cA",     actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
      { "n", "dX",             actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
    },
    file_history_panel = {
      { "n", "g!",            actions.options,                     { desc = "Open the option panel" } },
      { "n", "<C-A-d>",       actions.open_in_diffview,            { desc = "Open the entry under the cursor in a diffview" } },
      { "n", "y",             actions.copy_hash,                   { desc = "Copy the commit hash of the entry under the cursor" } },
      { "n", "L",             actions.open_commit_log,             { desc = "Show commit details" } },
      { "n", "X",             actions.restore_entry,               { desc = "Restore file to the state from the selected entry" } },
      { "n", "zo",            actions.open_fold,                   { desc = "Expand fold" } },
      { "n", "zc",            actions.close_fold,                  { desc = "Collapse fold" } },
      { "n", "h",             actions.close_fold,                  { desc = "Collapse fold" } },
      { "n", "za",            actions.toggle_fold,                 { desc = "Toggle fold" } },
      { "n", "zR",            actions.open_all_folds,              { desc = "Expand all folds" } },
      { "n", "zM",            actions.close_all_folds,             { desc = "Collapse all folds" } },
      { "n", "j",             actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",        actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",             actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<up>",          actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<cr>",          actions.select_entry,                { desc = "Open the diff for the selected entry" } },
      { "n", "o",             actions.select_entry,                { desc = "Open the diff for the selected entry" } },
      { "n", "l",             actions.select_entry,                { desc = "Open the diff for the selected entry" } },
      { "n", "<2-LeftMouse>", actions.select_entry,                { desc = "Open the diff for the selected entry" } },
      { "n", "<c-b>",         actions.scroll_view(-0.25),          { desc = "Scroll the view up" } },
      { "n", "<c-f>",         actions.scroll_view(0.25),           { desc = "Scroll the view down" } },
      { "n", "<tab>",         actions.select_next_entry,           { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",       actions.select_prev_entry,           { desc = "Open the diff for the previous file" } },
      { "n", "[F",            actions.select_first_entry,          { desc = "Open the diff for the first file" } },
      { "n", "]F",            actions.select_last_entry,           { desc = "Open the diff for the last file" } },
      { "n", "gf",            actions.goto_file_edit,              { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",    actions.goto_file_split,             { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",       actions.goto_file_tab,               { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",     actions.focus_files,                 { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",     actions.toggle_files,                { desc = "Toggle the file panel" } },
      { "n", "g<C-x>",        actions.cycle_layout,                { desc = "Cycle available layouts" } },
      { "n", "g?",            actions.help("file_history_panel"),  { desc = "Open the help panel" } },
    },
    option_panel = {
      { "n", "<tab>", actions.select_entry,          { desc = "Change the current option" } },
      { "n", "q",     actions.close,                 { desc = "Close the panel" } },
      { "n", "g?",    actions.help("option_panel"),  { desc = "Open the help panel" } },
    },
    help_panel = {
      { "n", "q",     actions.close,  { desc = "Close help menu" } },
      { "n", "<esc>", actions.close,  { desc = "Close help menu" } },
    },
  },
})

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
			add_comment = { lhs = "<leader>oc", desc = "add comment" },
			add_reply = { lhs = "<leader>oC", desc = "add reply" },
			resolve_thread = { lhs = "<leader>ot", desc = "resolve PR thread" },
			unresolve_thread = { lhs = "<leader>oT", desc = "unresolve PR thread" },
			add_reviewer = { lhs = "<leader>oa", desc = "unresolve PR thread" },
		},
		review_thread = {
			add_comment = { lhs = "<leader>oc", desc = "add comment" },
			add_reply = { lhs = "<leader>oC", desc = "add reply" },
			resolve_thread = { lhs = "<leader>ot", desc = "resolve PR thread" },
			unresolve_thread = { lhs = "<leader>oT", desc = "unresolve PR thread" },
		},
		review_diff = {
			add_review_comment = { lhs = "<leader>oc", desc = "add a new review comment", mode = { "n", "x" } },
		},
		notification = {
			read = { lhs = "<C-m>", desc = "mark notification as read" },
			done = { lhs = "<C-r>", desc = "mark notification as done" },
			unsubscribe = { lhs = "<C-t>", desc = "unsubscribe from notifications" },
		},
	},
	poll = {
		enabled = true,            -- opt-in polling for remote changes
		interval = 15000,          -- polling interval in milliseconds (default: 10s)
		notify_on_refresh = false, -- notify when a buffer is auto-refreshed
		notify_on_change = true,   -- notify when remote changed but buffer has local edits
	},
})

require("tiny-glimmer").setup({
	-- Enable/disable the plugin
	enabled = true,

	-- Disable warnings for debugging highlight issues
	disable_warnings = true,

	-- Automatically reload highlights when colorscheme changes
	-- When enabled, cached highlights will be refreshed on ColorScheme autocmd
	autoreload = false,

	-- Animation refresh rate in milliseconds
	refresh_interval_ms = 8,

	-- Timeout in milliseconds to wait after the last edit before processing animations
	-- This uses a debouncing approach: the timer restarts on each edit, and only fires
	-- when edits stop for this duration. This properly handles multi-location atomic
	-- edits from surround plugins and similar tools (default: 50)
	text_change_batch_timeout_ms = 50,

	-- Automatic keybinding overwrites
	overwrite = {
		-- Automatically map keys to overwrite operations
		-- Set to false if you have custom mappings or prefer manual API calls
		auto_map = true,

		-- Yank operation animation
		yank = {
			enabled = true,
			default_animation = "fade",
		},

		-- Search navigation animation
		search = {
			enabled = true,
			default_animation = "pulse",
			next_mapping = "n",      -- Key for next match
			prev_mapping = "N",      -- Key for previous match
		},

		-- Paste operation animation
		paste = {
			enabled = true,
			default_animation = "reverse_fade",
			paste_mapping = "p",     -- Paste after cursor
			Paste_mapping = "P",     -- Paste before cursor
		},

		-- Undo operation animation
		undo = {
			enabled = true,
			default_animation = {
				name = "fade",
				settings = {
					from_color = "DiffDelete",
					max_duration = 500,
					min_duration = 500,
				},
			},
			undo_mapping = "u",
		},

		-- Redo operation animation
		redo = {
			enabled = true,
			default_animation = {
				name = "fade",
				settings = {
					from_color = "DiffAdd",
					max_duration = 500,
					min_duration = 500,
				},
			},
			redo_mapping = "<c-r>",
		},
	},

	-- Third-party plugin integrations
	support = {
		-- Support for gbprod/substitute.nvim
		-- Usage: require("substitute").setup({
			--     on_substitute = require("tiny-glimmer.support.substitute").substitute_cb,
			--     highlight_substituted_text = { enabled = false },
			-- })
			substitute = {
				enabled = false,
				default_animation = "fade",
			},
		},

		-- Special animation presets
		presets = {
			-- Pulsar-style cursor highlighting on specific events
			pulsar = {
				enabled = false,
				on_events = { "CursorMoved", "CmdlineEnter", "WinEnter" },
				default_animation = {
					name = "fade",
					settings = {
						max_duration = 1000,
						min_duration = 1000,
						from_color = "DiffDelete",
						to_color = "Normal",
					},
				},
			},
		},

		-- Override background color for animations (for transparent backgrounds)
		transparency_color = nil,

		-- Animation configurations
		animations = {
			fade = {
				max_duration = 400,              -- Maximum animation duration in ms
				min_duration = 300,              -- Minimum animation duration in ms
				easing = "outQuad",              -- Easing function
				chars_for_max_duration = 10,     -- Character count for max duration
				from_color = "Visual",           -- Start color (highlight group or hex)
				to_color = "Normal",             -- End color (highlight group or hex)
				font_style = {},                 -- Additional font styling (e.g. { bold = true }, see `:h nvim_set_hl`)
			},
			reverse_fade = {
				max_duration = 380,
				min_duration = 300,
				easing = "outBack",
				chars_for_max_duration = 10,
				from_color = "Visual",
				to_color = "Normal",
				font_style = {},
			},
			bounce = {
				max_duration = 500,
				min_duration = 400,
				chars_for_max_duration = 20,
				oscillation_count = 1,          -- Number of bounces
				from_color = "Visual",
				to_color = "Normal",
				font_style = {},
			},
			left_to_right = {
				max_duration = 350,
				min_duration = 350,
				min_progress = 0.85,
				chars_for_max_duration = 25,
				lingering_time = 50,            -- Time to linger after completion
				from_color = "Visual",
				to_color = "Normal",
				font_style = {},
			},
			pulse = {
				max_duration = 600,
				min_duration = 400,
				chars_for_max_duration = 15,
				pulse_count = 2,                -- Number of pulses
				intensity = 1.2,                -- Pulse intensity
				from_color = "Visual",
				to_color = "Normal",
				font_style = {},
			},
			rainbow = {
				max_duration = 600,
				min_duration = 350,
				chars_for_max_duration = 20,
				-- Note: Rainbow animation does not use from_color/to_color
				font_style = {},
			},

			-- Custom animation example
			custom = {
				max_duration = 350,
				chars_for_max_duration = 40,
				color = "#ff0000",  -- Custom property

				-- Custom effect function
				-- @param self table - The effect object with settings
				-- @param progress number - Animation progress [0, 1]
				-- @return string color - Hex color or highlight group
				-- @return number progress - How much of the animation to draw
				effect = function(self, progress)
					return self.settings.color, progress
				end,
			},
		},

		-- Filetypes to disable hijacking/overwrites
		hijack_ft_disabled = {
			"alpha",
			"snacks_dashboard",
		},

		-- Virtual text display priority
		virt_text = {
			priority = 2048,  -- Higher values appear above other plugins
		},
	})

require("sudoku").setup({
  persist_settings = false,
  persist_games = false,
  default_mappings = true
})
