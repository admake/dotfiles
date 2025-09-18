vim.g.vim_markdown_folding_disabled = 1
vim.opt.conceallevel = 1

require("obsidian").setup({
	ui = { enable = false },
	workspaces = {
		{
			name = "personal",
			path = "~/SynologyDrive/vault/",
		},
	},

	-- Optional, if you keep notes in a specific subdirectory of your vault.
	notes_subdir = "notes",

	daily_notes = {
		-- Optional, if you keep daily notes in a separate directory.
		folder = "notes/dailies",
		-- Optional, if you want to change the date format for the ID of daily notes.
		date_format = "%Y-%m-%d",
		-- Optional, if you want to change the date format of the default alias of daily notes.
		alias_format = "%B %-d, %Y",
		-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
		template = "daily.md",
	},

	-- Where to put new notes created from completion. Valid options are
	--  * "current_dir" - put new notes in same directory as the current buffer.
	--  * "notes_subdir" - put new notes in the default notes subdirectory.
	new_notes_location = "notes_subdir",

	completion = {
		nvim_cmp = true,
		-- Trigger completion at 2 chars.
		min_chars = 2,
	},
	attachments = {
		-- The default folder to place images in via `:ObsidianPasteImg`.
		-- If this is a relative path it will be interpreted as relative to the vault root.
		-- You can always override this per image by passing a full path to the command instead of just a filename.
		img_folder = "assets/imgs", -- This is the default
	},

	-- Optional, for templates (see below).
	templates = {
		subdir = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
		-- A map for custom variables, the key should be the variable and the value a function
		substitutions = {},
	},

	-- Optional, customize how names/IDs for new notes are created.
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		-- In this case a note with the title 'My new note' will be given an ID that looks
		-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'

		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = title:gsub("[%p%c]", ""):gsub("%s", "-"):lower()
		else
			suffix = tostring(os.time())
		end
		return tostring(os.date("%Y-%m-%d")) .. "-" .. suffix
	end,
})
