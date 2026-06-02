vim.cmd("source ~/.vimrc")

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
			resolve_thread = { lhs = "<C-a>", desc = "resolve PR thread" },
			unresolve_thread = { lhs = "<C-t>", desc = "unresolve PR thread" },
			add_reviewer = { lhs = "<C-e>", desc = "unresolve PR thread" },
		},
		review_thread = {
			add_comment = { lhs = "<C-c>", desc = "add comment" },
			add_reply = { lhs = "<C-r>", desc = "add reply" },
			resolve_thread = { lhs = "<C-a>", desc = "resolve PR thread" },
			unresolve_thread = { lhs = "<C-t>", desc = "unresolve PR thread" },
		},
		review_diff = {
			add_review_comment = { lhs = "<C-c>", desc = "add a new review comment", mode = { "n", "x" } },
		},
		notification = {
			read = { lhs = "<C-r>", desc = "mark notification as read" },
			done = { lhs = "<C-a>", desc = "mark notification as done" },
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
