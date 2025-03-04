-- Setup for nvim-tree
-- Add keymap to open split with `s`.
local function nvim_tree_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		}
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
end

return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- nvim_tree_on_attach
			-- require("nvim-tree").setup({})
			require("nvim-tree").setup({
				on_attach = nvim_tree_on_attach,
				update_focused_file = {
					enable = true,
				},
			})
		end,
	},
}
