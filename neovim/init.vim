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
  " Completion
  call dein#add('Shougo/deoplete.nvim')
  " Linting
  call dein#add('w0rp/ale')
  " Git
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')
  " For Python
  call dein#add('numirias/semshi', {'on_ft': ['python']})

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


" Set colorscheme
if (has('termguicolors'))
  set termguicolors
endif
colorscheme onedark


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


" AutoComplete (deoplete)
call deoplete#custom#option('auto_complete', v:false)
let g:deoplete#enable_at_startup = 1
" tab-complete
inoremap <expr><tab> pumvisible() ? '\<c-n>' : '\<tab>'


" Linting
let g:ale_linters = {'python': ['pylint', 'pydocstyle', 'pyls']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'isort'],
\}
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 0
let g:ale_completion_enabled = 1


" Python Setup
let g:ale_python_black_options = '--line-length=79'
let g:python_highlight_all = 1