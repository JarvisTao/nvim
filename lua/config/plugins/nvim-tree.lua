local function my_on_attach(bufnr)
	local api = require('nvim-tree.api')

	local function opts(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	-- your removals and mappings go here
	vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
	vim.keymap.set('n', 'O', api.node.open.tab, opts('Open: New Tab'))
	vim.keymap.set('n', 'so', api.node.open.vertical, opts('Open: Vertical Split'))
	vim.keymap.set('n', 'ho', api.node.open.horizontal, opts('Open: Horizontal Split'))
	vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
end

M = {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- nvim-tree
		local opt = {
			noremap = true,
			silent = true,
		}
		vim.keymap.set("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
		vim.keymap.set("n", "<leader>m", ":NvimTreeToggle<CR>", opt)
		require("nvim-tree").setup({
			-- 完全禁止内置netrw
			disable_netrw = true,
			-- 不显示 git 状态图标
			git = {
				enable = true,
			},
			-- custom keymap setting
			on_attach = my_on_attach,
			-- project plugin 需要这样设置
			update_cwd = true,
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			filters = {
				-- 隐藏 .文件
				dotfiles = true,
				-- 隐藏 node_modules 文件夹
				-- custom = { "node_modules" },
			},
			view = {
				-- 宽度
				width = 34,
				-- 也可以 'right'
				side = "left",
				-- 不显示行数
				number = false,
				relativenumber = false,
				-- 显示图标
				signcolumn = "yes",
			},
			actions = {
				open_file = {
					-- 首次打开大小适配
					resize_window = true,
					-- 打开文件时关闭 tree
					quit_on_open = false,
				},
			},
			-- wsl install -g wsl-open
			-- https://github.com/4U6U57/wsl-open/
			system_open = {
				-- mac
				cmd = "open",
				-- windows
				-- cmd = "wsl-open",
			},
		})
	end
}
-- config = function()
-- 	require("nvim-tree").setup({
-- 		sort_by = "case_sensitive",
-- 		hijack_cursor = true,
-- 		open_on_setup = false,
-- 		open_on_setup_file = true,
-- 		ignore_buffer_on_setup = true,
-- 		system_open = {
-- 			cmd = "open",
-- 		},
-- 		view = {
-- 			width = 5,
-- 			adaptive_size = true,
-- 		},
-- 		renderer = {
-- 			group_empty = true,
-- 			icons = {
-- 				show = {
-- 					git = true,
-- 					file = false,
-- 					folder = false,
-- 					folder_arrow = true,
-- 				},
-- 				glyphs = {
-- 					bookmark = "🔖",
-- 					folder = {
-- 						arrow_closed = "⏵",
-- 						arrow_open = "⏷",
-- 					},
-- 					git = {
-- 						unstaged = "✗",
-- 						staged = "✓",
-- 						unmerged = "⌥",
-- 						renamed = "➜",
-- 						untracked = "★",
-- 						deleted = "⊖",
-- 						ignored = "◌",
-- 					},
-- 				},
-- 			},
-- 		},
-- 		filters = {
-- 			dotfiles = false,
-- 		},
-- 	})
-- end

return M
