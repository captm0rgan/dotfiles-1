return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	config = function()
		local key = vim.keymap.set
		local telescope = require("telescope")
		local lga_actions = require("telescope-live-grep-args.actions")
		telescope.setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = { width = 0.8, preview_width = 0.65, anchor = "CENTER" },
				},
			},
			extensions = {
				undo = {
					use_delta = true,
					side_by_side = true,
					diff_context_lines = 6, -- vim.o.scrolloff,
					entry_format = "state #$ID, $STAT, $TIME",
					time_format = "",
					layout_strategy = "vertical",
					layout_config = {
						vertical = { preview_width = 0.65 },
					},
					mappings = {
						i = {
							["<cr>"] = require("telescope-undo.actions").yank_additions,
							["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
							["<C-cr>"] = require("telescope-undo.actions").restore,
						},
					},
				},
				live_grep_args = {
					auto_quoting = true,
					mappings = {
						i = {
							["<C-\\>"] = lga_actions.quote_prompt({ postfix = " --hidden " }),
						}
					},
				},
			},
		})
		telescope.load_extension("undo")
		telescope.load_extension("live_grep_args")
		key("n", "<leader>u", ":Telescope undo<cr>")
		key("n", "\\", ":Telescope live_grep_args<cr>")
	end,
}
