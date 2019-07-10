scriptencoding utf-8
set encoding=utf-8

call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " use `.`

" Languages
Plug 'hashivim/vim-terraform'
Plug 'sheerun/vim-polyglot' " includes: pangloss/vim-javascript, elzr/vim-json, elmcast/elm-vim, derekwyatt/vim-scala

" Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish' " use `-` to naviate directories
Plug 'moll/vim-node' " use `gf` on file paths
"Plug 'geekjuice/vim-mocha' " use `,t` and `,T` to run test suites (mocha and istanbul)

" Look and Feel
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'

" Utilities
"Plug 'janko/vim-test'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete / suggestions
Plug 'w0rp/ale' " asynchronous linting engine
Plug 'aloiscochard/sarsi' " sbt quickfix

call plug#end()

" Colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme materialbox
set background=dark " for color scheme
set termguicolors

" General [ •  ★ › ▸ ▶ ⁞ Ξ ]
set colorcolumn=80 " ruler
set completeopt=longest,menuone
set dir=~/.swp " location of swapfiles
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

let g:lightline = { 'colorscheme': 'materia' }
let g:ale_sign_error = '››'
let g:coverage_show_uncovered = 0
let g:dirvish_mode = ':sort ,^.*[\/],' " directory explorer
let g:gitgutter_map_keys=1
let g:gitgutter_signs=1
let g:python3_host_prog = '/usr/bin/python3'
let mapleader=" "

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

" shift lines
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" fuzzy finder
map <C-p> :GFiles<CR>
