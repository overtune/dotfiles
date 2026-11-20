-- Completion: https://cmp.saghen.dev
-- The menu opens as you type, with suggestions from the language server,
-- file paths, snippets and words in open buffers.
--
-- Keys while the menu is open:
--   <Tab> / <S-Tab>   next / previous suggestion
--   <CR>              accept the selected suggestion (a new line if none is selected)
--   <C-e>             close the menu
--   <C-Space>         open the menu by hand / toggle the docs
--   <C-k>             toggle signature help
-- In a snippet, <Tab> / <S-Tab> jump between its placeholders. If the menu
-- opens while you type in a placeholder, <Tab> still jumps until you pick an
-- item there (use <Down> / <Up> to move through the menu instead).

-- Jump to the next/previous snippet placeholder, unless an item is selected.
local function snippet_jump(direction)
	return function(cmp)
		if cmp.snippet_active({ direction = direction }) and not cmp.get_selected_item() then
			cmp.hide()
			return direction == 1 and cmp.snippet_forward() or cmp.snippet_backward()
		end
	end
end

return {
	{
		"saghen/blink.cmp",
		-- Release tags ship a prebuilt fuzzy matcher, so no Rust toolchain is needed.
		version = "1.*",
		-- Load at startup: blink registers its LSP capabilities (snippets,
		-- auto-imports) via vim.lsp.config("*") and must do so before the
		-- servers start. It defers its own work until you type.
		lazy = false,
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "none",
				["<Tab>"] = { snippet_jump(1), "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { snippet_jump(-1), "select_prev", "snippet_backward", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-e>"] = { "cancel", "fallback" },
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<Down>"] = { "select_next", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
			completion = {
				-- Nothing is selected until you press <Tab>, and selecting does
				-- not insert text; <CR> inserts it (with snippets and imports).
				list = { selection = { preselect = false, auto_insert = false } },
				-- The Svelte server lists `$` as a trigger character but answers it
				-- with nothing inside <script>; without this, typing `$der` never
				-- offers `$derived`.
				trigger = { show_on_blocked_trigger_characters = { " ", "\n", "\t", "$" } },
				-- Add () after functions and place the cursor inside.
				accept = { auto_brackets = { enabled = true } },
				documentation = { auto_show = true, auto_show_delay_ms = 300 },
			},
			signature = { enabled = true },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},
}
