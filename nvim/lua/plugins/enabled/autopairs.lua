return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		-- <CR> is mapped in lua/completion.lua, which calls autopairs itself
		-- when no completion item is selected.
		opts = { map_cr = false },
	},
}
