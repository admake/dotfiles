vim.g.vim_markdown_folding_disabled = 1
vim.opt.conceallevel = 1

local obsidian = require("obsidian")
obsidian.setup({
	ui = { enable = false },
	legacy_commands = false,
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
		blink = true,
		nvim_cmp = false,
		-- Trigger completion at 2 chars.
		min_chars = 2,
	},
	attachments = {
		-- The default folder to place images in via `:ObsidianPasteImg`.
		-- If this is a relative path it will be interpreted as relative to the vault root.
		-- You can always override this per image by passing a full path to the command instead of just a filename.
		folder = "assets/imgs", -- This is the default
		-- A function that determines the text to insert in the note when pasting an image.
		-- It takes t.o arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
		-- This is the default implementation.
		---@param client obsidian.Client
		---@param path obsidian.Path the absolute path to the image file
		---@return string
		img_text_func = function(client, path)
			path = client:vault_relative_path(path) or path
			return string.format("![%s](%s)", path.name, path)
		end,
		confirm_img_paste = false,
	},

	-- Optional, for templates (see belo.).
	templates = {
		subdir = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
		-- A map for custom variables, the key should be the variable and the value a function
		substitutions = { -- Пользовательские переменные
			yesterday = function()
				return os.date("%Y-%m-%d", os.time() - 86400)
			end,
			tomorrow = function()
				return os.date("%Y-%m-%d", os.time() + 86400)
			end,
		},
	},

	-- Переопределяем поведение перехода по ссылке
	follow_link_func = function(client, link)
		-- 1. Пытаемся найти существующую заметку
		local note = client:find_note(link)
		if note then
			client:open_note(note)
			return
		end

		-- 2. Нет заметки — создаём новую из шаблона
		local template_name = "unique" -- имя без .md
		-- create_note с опцией template (работает в obsidian.nvim >= 2.x)
		local new_note = client:create_note(link, {
			id = link,
			template = template_name, -- автоматически применит шаблон из папки templates
		})
		if new_note then
			client:open_note(new_note)
		else
			vim.notify("Failed to create note from template", vim.log.levels.ERROR)
		end
	end,

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

-- Функция для создания заметки из шаблона при переходе по ссылке
function CreateNoteFromTemplate()
	local obsidian = require("obsidian")
	local client = obsidian.get_client()
	if not client then
		print("Obsidian client not found")
		return
	end

	-- Получаем текст под курсором (работает с [[link]] и простыми словами)
	local cursor_word = vim.fn.expand("<cfile>")
	-- Убираем квадратные скобки, если они есть (поддержка вики-ссылок)
	local note_name = cursor_word:match("^%[%[(.+)%]%]$") or cursor_word
	if note_name == "" or note_name == cursor_word and not cursor_word:match("%w") then
		print("No valid link under cursor")
		return
	end

	-- Формируем путь к файлу заметки
	local vault_path = client:vault_path()
	local note_path = vault_path .. "/" .. note_name .. ".md"

	-- Проверяем, существует ли уже такая заметка
	if vim.fn.filereadable(note_path) == 1 then
		-- Если существует, открываем её стандартным способом
		vim.cmd("ObsidianFollowLink")
		return
	end

	-- Задаём путь к шаблону (⚠️ ИЗМЕНИТЕ ПОД СЕБЯ)
	local template_path = vault_path .. "/templates/unique.md" -- например

	local template_file = io.open(template_path, "r")
	if not template_file then
		print("Template file not found: " .. template_path)
		-- Можно создать пустую заметку, если шаблона нет
		template_file = nil
	end

	local content = ""
	if template_file then
		content = template_file:read("*a")
		template_file:close()
	else
		-- Если шаблона нет, создаём минимальную структуру
		content = "# " .. note_name .. "\n\n"
	end

	-- Создаём новую заметку через API плагина
	local new_note = client:create_note(note_name)
	new_note:write(content, { write_opts = { overwrite = false } })
	new_note:save()

	-- Открываем созданную заметку
	client:open_note(new_note)
end
