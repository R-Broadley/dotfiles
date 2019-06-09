let dein_dir = fnamemodify('~/.local/share/nvim/dein', ':p')
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
let &runtimepath.=','.escape(dein_dir.'repos/github.com/Shougo/dein.vim', '\,')

" Required:
if dein#load_state(dein_dir)
  call dein#begin(dein_dir)

  " Let dein manage dein
  " Required:
  call dein#add(dein_dir . 'repos/github.com/Shougo/dein.vim')

  " Visual
  call dein#add('joshdick/onedark.vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('sheerun/vim-polyglot')
  " Editor Config
  call dein#add('editorconfig/editorconfig-vim')
  " Linting
  call dein#add('w0rp/ale')
  " Git
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')
  " For Python
  call dein#add('numirias/semshi', {'on_ft': ['python']})
  " For Pandoc / Markdown
  call dein#add('vim-pandoc/vim-pandoc')
  call dein#add('vim-pandoc/vim-pandoc-syntax')
  call dein#add('junegunn/goyo.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------


" Basic Config
set guioptions=M
set mouse=a
set number
set splitbelow
set breakindent
set showbreak=->
set expandtab
" Use tabs for make files
autocmd FileType make setlocal noexpandtab
" Spelling
set spell spelllang=en_gb


" Light the Scroll Lock LED when in insert mode
augroup ScrollLockLED
    autocmd!
    autocmd InsertEnter * :silent !xset  led named 'Scroll Lock'
    autocmd InsertLeave * :silent !xset -led named 'Scroll Lock'
    autocmd VimLeave    * :silent !xset -led named 'Scroll Lock'
augroup END


" Status Line
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \     'left': [
    \         [ 'mode', 'paste' ],
    \         [ 'gitbranch', 'readonly', 'filename', 'modified' ]
    \     ]
    \ },
    \ 'component_function': {
    \     'gitbranch': 'fugitive#head'
    \ },
\}
let g:lightline.separator = {
	\ 'left': '', 'right': ''
\}
let g:lightline.subseparator = {
	\ 'left': '', 'right': ''
\}


" Set colorscheme
if (has('termguicolors'))
  set termguicolors
endif
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif
colorscheme onedark


" Goyo
let g:goyo_width = 100
let g:goyo_height = '100%'


" Completion
set complete+=kspell
inoremap <silent> <C-s> <C-x><C-k>
inoremap <silent> <S-Tab> <C-x><Tab>


" Linting
let g:ale_linters = {'python': ['pylint', 'pydocstyle', 'pyls']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'isort'],
\}
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 0
let g:ale_completion_enabled = 1
set completeopt=menu,menuone,preview,noselect,noinsert


" Python Setup
let g:ale_python_black_options = '--line-length=79'
let g:python_highlight_all = 1
