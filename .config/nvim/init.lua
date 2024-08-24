

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},

	}, {
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension "frecency"
		end
    	},
	{"neoclide/coc.nvim", branch = "release", build = ":CocUpdate"}, -- auto complete
    	{"honza/vim-snippets"}, -- Snippets are separated from the engine
	{
		"numToStr/Comment.nvim",
		opts = {
			sticky = false,
			padding = true,
		}
	},
	{
		"nvim-treesitter/nvim-treesitter", 
		build = ":TSUpdate",
		--[[opts = {
			highlight = { enable=true },
			indent = { enable = true },
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "java", "kotlin" },
			incremental_selection = { 
				enable = true, 
				keymaps = {
					init_selection = "<C-space>", 
					node_incremental = "<C-space>", 
					scope_incremental = false,
					node_decremental = "<bs>", 
				}, 
			},
		},]]
		config = function () 
			local configs =require("nvim-treesitter.configs")

			configs.setup({ 
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "java", "kotlin" },
				sync_install = false, 
				highlight = { 
					enable = true 
				}, 
				indent = { enable = true },  
			}) 
		end
	}, -- :TSInstallFromGrammar
	{"nvim-treesitter/nvim-treesitter-textobjects", event = "InsertEnter"}, -- TS objects
	{"JoosepAlviste/nvim-ts-context-commentstring"}, -- use TS for comment.nvim
	{"nvim-treesitter/playground", lazy = true, cmd = "TSPlaygroundToggle"}, -- playing around with treesitter
	{"sbdchd/neoformat"}, -- format code
	{"mbbill/undotree", lazy = true, cmd = "UndotreeToggle"}, -- see undo tree
	{
		"rmagatti/auto-session", -- auto save session
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = {
					"~/", "~/Downloads", "~/Documents"
				},
				auto_session_use_git_branch = true,
				auto_save_enabled = true
			})
		end
	},
	{
		"kylechui/nvim-surround", -- surround objects
		config = function() require("nvim-surround").setup({}) end
	},
	{"gelguy/wilder.nvim", build = ":UpdateRemotePlugins"}, -- : autocomplete
	{"tpope/vim-fugitive"}, -- Git control for vim
	{"uga-rosa/ccc.nvim"}, -- color highlighting
	{"vhyrro/luarocks.nvim", priority = 1000, config = true},
	{"nvim-neorg/neorg", dependencies = {"luarocks.nvim"}}, 
	{
		"edluffy/hologram.nvim",
		lazy = true,
		config = function()
			require("hologram").setup({
				auto_display = true -- WIP automatic markdown image display, may be prone to breaking
			})
		end
	},
	{
		"navarasu/onedark.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function(_, opts)
		    require("onedark").setup(opts)
		    require("onedark").load()
		end,
		opts = {
		    -- Main options --
		    style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
		    transparent = false, -- Show/hide background
		    term_colors = true, -- Change terminal color as per the selected theme style
		    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
		    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
		    -- toggle theme style ---
		    toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
		    -- List of styles to toggle between
		    toggle_style_list = {
			"dark",
			"darker",
			"cool",
			"deep",
			"warm",
			"warmer",
			"light",
		    },
		    -- Change code style ---
		    -- Options are italic, bold, underline, none
		    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
		    code_style = {
			comments = "italic",
			keywords = "none",
			functions = "none",
			strings = "none",
			variables = "none",
		    },
		    -- Lualine options --
		    lualine = {
			transparent = false, -- lualine center bar transparency
		    },
		    -- Custom Highlights --
		    colors = {}, -- Override default colors
		    highlights = {}, -- Override highlight groups
		    -- Plugins Config --
		    diagnostics = {
			darker = true, -- darker colors for diagnostic
			undercurl = true, -- use undercurl instead of underline for diagnostics
			background = true, -- use background color for virtual text
		    },
		},
	},
	--[[]{
		"ellisonleao/gruvbox.nvim", -- theme
		priority = 1000,
		config = function()
		    require("gruvbox").setup({
			contrast = "hard",
			palette_overrides = {dark0_hard = "#0E1018"},
			overrides = {
			    -- Comment = {fg = "#626A73", italic = true, bold = true},
			    -- #736B62,  #626273, #627273
			    NormalFloat = {fg = "#ebdbb2", bg = "#504945"},
			    Comment = {fg = "#81878f", italic = true, bold = true},
			    Define = {link = "GruvboxPurple"},
			    Macro = {link = "GruvboxPurple"},
			    ["@constant.builtin"] = {link = "GruvboxPurple"},
			    ["@storageclass.lifetime"] = {link = "GruvboxAqua"},
			    ["@text.note"] = {link = "TODO"},
			    ["@namespace.rust"] = {link = "Include"},
			    ["@punctuation.bracket"] = {link = "GruvboxOrange"},
			    texMathDelimZoneLI = {link = "GruvboxOrange"},
			    texMathDelimZoneLD = {link = "GruvboxOrange"},
			    ContextVt = {fg = "#878788"},
			    CopilotSuggestion = {fg = "#878787"},
			    CocCodeLens = {fg = "#878787"},
			    CocWarningFloat = {fg = "#dfaf87"},
			    CocInlayHint = {fg = "#ABB0B6"},
			    CocPumShortcut = {fg = "#fe8019"},
			    CocPumDetail = {fg = "#fe8019"},
			    DiagnosticVirtualTextWarn = {fg = "#dfaf87"},
			    -- fold
			    Folded = {fg = "#fe8019", bg = "#3c3836", italic = true},
			    FoldColumn = {fg = "#fe8019", bg = "#0E1018"},
			    SignColumn = {bg = "#fe8019"},
			    -- new git colors
			    DiffAdd = {
				bold = true,
				reverse = false,
				fg = "",
				bg = "#2a4333"
			    },
			    DiffChange = {
				bold = true,
				reverse = false,
				fg = "",
				bg = "#333841"
			    },
			    DiffDelete = {
				bold = true,
				reverse = false,
				fg = "#442d30",
				bg = "#442d30"
			    },
			    DiffText = {
				bold = true,
				reverse = false,
				fg = "",
				bg = "#213352"
			    },
			    -- statusline
			    StatusLine = {bg = "#ffffff", fg = "#0E1018"},
			    StatusLineNC = {bg = "#3c3836", fg = "#0E1018"},
			    CursorLineNr = {fg = "#fabd2f", bg = ""},
			    GruvboxOrangeSign = {fg = "#dfaf87", bg = ""},
			    GruvboxAquaSign = {fg = "#8EC07C", bg = ""},
			    GruvboxGreenSign = {fg = "#b8bb26", bg = ""},
			    GruvboxRedSign = {fg = "#fb4934", bg = ""},
			    GruvboxBlueSign = {fg = "#83a598", bg = ""},
			    WilderMenu = {fg = "#ebdbb2", bg = ""},
			    WilderAccent = {fg = "#f4468f", bg = ""},
			    -- coc semantic token
			    CocSemStruct = {link = "GruvboxYellow"},
			    CocSemKeyword = {fg = "", bg = "#0E1018"},
			    CocSemEnumMember = {fg = "", bg = "#0E1018"},
			    CocSemTypeParameter = {fg = "", bg = "#0E1018"},
			    CocSemComment = {fg = "", bg = "#0E1018"},
			    CocSemMacro = {fg = "", bg = "#0E1018"},
			    CocSemVariable = {fg = "", bg = "#0E1018"},
			    CocSemFunction = {fg = "", bg = "#0E1018"},
			    -- neorg
			    ["@neorg.markup.inline_macro"] = {link = "GruvboxGreen"}
			}
		    })
		    vim.cmd.colorscheme("gruvbox")
	    end
	},]]
	{
		'lervag/vimtex',
		lazy = false,
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = 'zathura'
			--vim.g.vimtex_compiler_method = 'pdflatex'
		end
	},
	{'nvim-lua/plenary.nvim'},
	{'ThePrimeagen/harpoon'},
	{'ziglang/zig.vim'},
	{'RaafatTurki/hex.nvim'},
})

require('hex').setup()

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- set mouse to be on
vim.opt.undofile = true -- undo even when it closes

vim.opt.foldmethod = "expr" -- treesiter time
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- treesiter
vim.cmd([[ set nofoldenable]])

vim.opt.breakindent = true -- break indentation for long lines
vim.opt.breakindentopt = {shift = 2}
vim.opt.showbreak = "↳" -- character for line break

vim.opt.wildmode = "list:longest,list:full" -- for : stuff
vim.opt.wildignore:append({".javac", "node_modules", "*.pyc"})
vim.opt.wildignore:append({".aux", ".out", ".toc"}) -- LaTeX
vim.opt.wildignore:append({
    ".o", ".obj", ".dll", ".exe", ".so", ".a", ".lib", ".pyc", ".pyo", ".pyd",
    ".swp", ".swo", ".class", ".DS_Store", ".git", ".hg", ".orig"
})

local human_file_size = function()
    local format_file_size = function(file)
        local size = vim.fn.getfsize(file)
        if size <= 0 then return "" end
        local sufixes = {"B", "KB", "MB", "GB"}
        local i = 1
        while size > 1024 do
            size = size / 1024
            i = i + 1
        end
        return string.format("[%.0f%s]", size, sufixes[i])
    end

    local file = vim.api.nvim_buf_get_name(0)
    if string.len(file) == 0 then return "" end
    return format_file_size(file)
end

local smart_file_path = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name == "" then return "[No Name]" end
    local is_term = false
    local file_dir = ""

    if buf_name:sub(1, 5):find("term") ~= nil then
        ---@type string
        file_dir = vim.env.PWD
        if file_dir == home then return "$HOME " end
        is_term = true
    else
        file_dir = vim.fs.dirname(buf_name)
    end

    ---@diagnostic disable-next-line: need-check-nil
    file_dir = file_dir:gsub(home, "~", 1)

    if vim.api.nvim_win_get_width(0) <= 80 then
        file_dir = vim.fn.pathshorten(file_dir)
    end

    if is_term then
        return file_dir .. " "
    else
        return string.format("%s/%s ", file_dir, vim.fs.basename(buf_name))
    end
end

local word_count = function()
    local words = vim.fn.wordcount()
    if words.visual_words ~= nil then
        return string.format("[%s]", words.visual_words)
    else
        return string.format("[%s]", words.words)
    end
end

vim.g.mapleader = " "

local keyset = vim.keymap.set

keyset("n", "<leader>x", "ZZ")

local builtin = require('telescope.builtin')
keyset('n', '<leader>ff', builtin.find_files, {})
keyset('n', '<leader>fg', builtin.live_grep, {})
keyset('n', '<leader>fb', builtin.buffers, {})
keyset('n', '<leader>fh', builtin.help_tags, {})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

keyset("n", "<leader>a", mark.add_file)
keyset("n", "<C-e>", ui.toggle_quick_menu)

keyset("n", "<C-h>", function() ui.nav_file(1) end)
keyset("n", "<C-t>", function() ui.nav_file(2) end)
keyset("n", "<C-n>", function() ui.nav_file(3) end)
keyset("n", "<C-s>", function() ui.nav_file(4) end)

---
--- CoC
---

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = {silent = true, noremap = true, expr = true}

keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})
-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)



local ccc = require("ccc")
ccc.setup({
    highlighter = {auto_enable = true},
    pickers = {
        ccc.picker.hex, ccc.picker.css_rgb, ccc.picker.css_hsl,
        ccc.picker.css_name
    }
})

vim.g.tex_flavor = "latex"
vim.g.tex_conceal = "abdmgs"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_latexmk_engines = {["_"] = "-lualatex -shell-escape"}
vim.g.vimtex_indent_on_ampersands = 0
vim.g.vimtex_view_method = 'sioyek'
vim.g.matchup_override_vimtex = 1

-- vimtex
vim.g.tex_compiles_successfully = false
vim.g.term_pdf_vierer_open = false

vim.api.nvim_create_augroup("CustomTex", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd("User", {
	group = "CustomTex",
	pattern = "VimtexEventCompileSuccess",
	callback = function()
		vim.g.tex_compiles_successfully = true
		
		-- a hacky way to reload the pdf in the terminal when it has changed
		if vim.g.term_pdf_vierer_open and vim.g.tex_compiles_successfully then
			local command = "zathura " .. vim.api.nvim_call_function("expand", {"%:r"}) .. ".pdf"
			--local kitty = "kitty @ send-text --match title:termpdf "
			vim.fn.system(command)
			--vim.fn.system("kitty @ send-text --match title:termpdf G")
		end
	end
})

autocmd("User", {
    group = "CustomTex",
    pattern = "VimtexEventCompileFailed",
    callback = function() vim.g.tex_compiles_successfully = false end
})

function VimtexPDFToggle()
	vim.fn.system("zathura" .. vim.api.nvim_call_function("expand", {"%:r"}) .. ".pdf")
end

keyset("n", "<leader>q", ":lua VimtexPDFToggle()<cr>")

vim.g.vimtex_view_method = 'zathura'

vim.g.neoformat_run_all_formatters = 1
-- Enable alignment
vim.g.neoformat_basic_format_align = 1
-- Enable tab to spaces conversion
vim.g.neoformat_basic_format_retab = 1
-- Enable trimmming of trailing whitespace
vim.g.neoformat_basic_format_trim = 1

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-j>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-l>", { desc = "Move focus to the right window" })
--vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
--vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

require("telescope").setup {
	defaults = {
		preview = {
			mime_hook = function(filepath, bufnr, opts)
				local is_image = function(filepath)
					local image_extensions = {'png','jpg'}   -- Supported image formats
					local split_path = vim.split(filepath:lower(), '.', {plain=true})
					local extension = split_path[#split_path]
					return vim.tbl_contains(image_extensions, extension)
				end
				if is_image(filepath) then
					local term = vim.api.nvim_open_term(bufnr, {})

					local function send_output(_, data, _ )
						for _, d in ipairs(data) do
							vim.api.nvim_chan_send(term, d..'\r\n')
						end
					end
					vim.fn.jobstart(
						{'catimg', filepath}, 
						{on_stdout=send_output, stdout_buffered=true, pty=true})
				else
					require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
				end
			end
		},
		file_ignore_patterns = { 
			"node_modules/", ".git/",
			"%.a", "%.o", "%.class"
		}
	}
}


