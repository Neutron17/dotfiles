set mouse=a

set foldmethod=manual

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
let g:python3_host_prog = '/usr/bin/python3'

" switch between hpp and cpp
au BufEnter,BufNew *.c nnoremap <silent> ,p :e %<.h<CR>
au BufEnter,BufNew *.h nnoremap <silent> ,p :e %<.c<CR>

au BufEnter,BufNew *.c nnoremap <silent> ,vp :leftabove vs %<.h<CR>
au BufEnter,BufNew *.h nnoremap <silent> ,vp :rightbelow vs %<.c<CR>

au BufEnter,BufNew *.c nnoremap <silent> ,xp :leftabove split %<.h<CR>
au BufEnter,BufNew *.h nnoremap <silent> ,xp :rightbelow split %<.c<CR>

" autocmd BufWritePost *.c !make -C ..

autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
" set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with
set hlsearch                " highlight search
set incsearch               " incremental search
"set tabstop=4               " number of columns occupied by a tab
"set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim


call plug#begin("~/.vim/plugged")
 " Plugin Section
 Plug 'dracula/vim'
 Plug 'ryanoasis/vim-devicons'
 Plug 'SirVer/ultisnips'
 Plug 'honza/vim-snippets'
 Plug 'scrooloose/nerdtree'
 Plug 'preservim/nerdcommenter'
 Plug 'mhinz/vim-startify'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'https://github.com/preservim/nerdtree' " NerdTree
 Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
 Plug 'https://github.com/vim-airline/vim-airline' " Status bar
 Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
 Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
 Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
 Plug 'lervag/vimtex'
 Plug 'navarasu/onedark.nvim'
 Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

set encoding=UTF-8

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

nmap <F8> :TagbarToggle<CR>

set termguicolors
"if (has(“termguicolors”))
" set termguicolors
" endif
 syntax enable
let g:onedark_config = {
    \ 'style': 'warm',
\}
" colorscheme evening
colorscheme onedark

" move line or visually selected block - alt+j/k
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" move split panes to left/bottom/top/right
 nnoremap <A-h> <C-W>H
 nnoremap <A-j> <C-W>J
 nnoremap <A-k> <C-W>K
 nnoremap <A-l> <C-W>L
 " move between panes to left/bottom/top/right
 nnoremap <C-h> <C-w>h
 nnoremap <C-j> <C-w>j
 nnoremap <C-k> <C-w>k
 nnoremap <C-l> <C-w>l

" open file in a text by placing text and gf
nnoremap gf :vert winc f<cr>
" copies filepath to clipboard by pressing yf
:nnoremap <silent> yf :let @+=expand('%:p')<CR>
" copies pwd to clipboard: command yd
:nnoremap <silent> yd :let @+=expand('%:p:h')<CR>
" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' }}
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" for motions
nnoremap <silent> <leader>c} V}:call NERDComment('x', ‘toggle’)<CR>
noremap <silent> <leader>c{ V{:call NERDComment('x', ‘toggle’)<CR>

let g:startify_bookmarks = ['~/.bashrc','~/Documents/']

let g:UltiSnipsSnippetDirectories=[$HOME, '/.config/nvim/UltiSnips']

let g:coc_global_extensions = [
             \ 'coc-pairs',
             \ 'coc-snippets',
             \ 'coc-tsserver',
             \ 'coc-clangd',
             \ 'coc-json',
             \ 'coc-pyright',
             \ 'coc-sh',
             \ ]
            " \ 'coc-html',
            " \ 'coc-css',

set signcolumn=yes
inoremap <silent><expr> <TAB>
   \ pumvisible() ? coc#_select_confirm() :
   \ coc#expandableOrJumpable() ?
   \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
   \ <SID>check_back_space() ? "\<TAB>" :
   \ coc#refresh()

function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
 endfunction

let g:coc_snippet_next = '<tab>'

function TrimWhitespace()
 let l = line(".")
 let c = col(".")
 %s/\s\+$//e
 call cursor(l, c)
endfun

autocmd BufWritePre * :call TrimWhitespace()
nnoremap <F5> :call TrimWhitespace()<CR>

" LaTeX

" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexrun'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","

let g:tex_flavor = 'latex'
