scriptencoding utf-8
set encoding=utf-8

call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " use `.`
Plug 'tpope/vim-fugitive' " git

" Languages
Plug 'hashivim/vim-terraform'
Plug 'sheerun/vim-polyglot' " includes: pangloss/vim-javascript, elzr/vim-json, elmcast/elm-vim, derekwyatt/vim-scala

" Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish' " use `-` to naviate directories
Plug 'moll/vim-node' " use `gf` on file paths

" Look and Feel
Plug 'airblade/vim-gitgutter'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'

" Utilities
Plug 'janko/vim-test'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete / suggestions
Plug 'w0rp/ale' " asynchronous linting engine

call plug#end()

" General [ •  ★ › ▸ ▶ ⁞ Ξ ]

set colorcolumn=80 " ruler
set completeopt=longest,menuone
set dir=~/.cache/nvim-swap
set foldlevelstart=2
set foldmethod=syntax
set ignorecase " case-insensitive search
set list
set listchars=tab:▸▸,nbsp:•,extends:»,precedes:«,trail:•
set noshowmode " provided by vim-lightline
set nowrap
set number
set splitbelow
set splitright
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set updatetime=100 " faster updates for vim-gitgutter

let g:ale_sign_error = '››'
let g:coverage_show_uncovered = 0
let g:dirvish_mode = ':sort ,^.*[\/],' " directory explorer
let g:gitgutter_map_keys=1
let g:gitgutter_signs=1
let g:python3_host_prog = '/usr/bin/python3'
let mapleader=","

" ale
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_linters = {
\  'javascript': [ 'standard' ],
\  'javascript.jsx': [ 'standard' ],
\  'json': ['jsonlint']
\}

" terraform
let g:terraform_fmt_on_save = 0
let g:terraform_align = 1
let g:terraform_fold_sections = 1

" reload changed files
autocmd FocusGained * :checktime
set autoread

" remove trailing whitespace in files on save
autocmd BufWritePre * :%s/\s\+$//e

" API Blueprint
autocmd BufNewFile,BufRead *.apib set nonu | set spell | set lbr | set textwidth=0 | set nolist | set showbreak=↳

" Markdown
let g:markdown_fenced_languages = ['html', 'json', 'css', 'javascript', 'elm', 'vim']
autocmd BufNewFile,BufRead *.md set nonu | set spell | set wrap | set lbr | set textwidth=0 | set nolist | set showbreak=↳

" fuzzy finder
map <C-p> :GFiles<CR>

" run tests
let test#javascript#mocha#file_pattern = '\.js'
map <leader>t :TestFile<CR>

" shift lines
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" Colors

let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:lightline = {                                                                                                                                                  
  \   'colorscheme': 'onedark',
  \   'component_function': { 'filename': 'LightlineFilename' }
  \ }

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

set background=dark " for color scheme?
colorscheme onedark
