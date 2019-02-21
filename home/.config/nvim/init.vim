scriptencoding utf-8
set encoding=utf-8

source ~/.local/share/nvim/site/autoload/setcolors.vim

call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot' " includes: pangloss/vim-javascript, elzr/vim-json, elmcast/elm-vim, derekwyatt/vim-scala
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " use `.` for more stuff

" Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish' " use `-` to naviate directories
Plug 'moll/vim-node' " use `gf` on file paths

" Look and Feel
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'

" Utilities
Plug 'Shougo/deoplete.nvim' " suggestion engine
Plug 'carlitux/deoplete-ternjs' " suggestion provider?
Plug 'ruanyl/coverage.vim' " show coverage in gutter, configure path and symbols below
Plug 'tapayne88/vim-mochajs' " mocha compiler, reqires 'tap' output
Plug 'w0rp/ale' " async lint engine, map languages to commands below

call plug#end()

" General
set ignorecase
set nofoldenable
set foldmethod=syntax
set noshowmode " provided by vim-lightline
set noswapfile
set nowrap
set number
set splitbelow
set splitright
set completeopt=longest,menuone
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set list
let mapleader=" "
let g:coverage_json_report_path = 'coverage/coverage.raw.json'
let g:coverage_show_covered = 0
let g:coverage_show_uncovered = 0
let g:dirvish_mode = ':sort ,^.*[\/],' " directory explorer
let g:gitgutter_map_keys = 0
let g:gitgutter_signs = 1
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" Characters: •  ★ › ▸ ▶ ⁞ Ξ
let g:ale_sign_error = '››'
let g:coverage_sign_covered = '□'
let g:coverage_sign_uncovered = '■'
set listchars=tab:▸▸,nbsp:•,extends:»,precedes:«,trail:•

" Colors
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=238
colorscheme Revolution
set background=dark " for color scheme
set colorcolumn=80
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
"let g:lightline = { 'colorscheme': 'wombat' }

" auto reload changed files
autocmd FocusGained * :checktime
set autoread

" remove trailing whitespace in files on save
autocmd BufWritePre * :%s/\s\+$//e

" Ale
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_linters = {
\  'javascript': [ 'standard' ],
\  'javascript.jsx': [ 'standard' ],
\  'json': ['jsonlint']
\}

" Code completion, powered by Deoplete and Tern
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#filetypes = [
\  'javascript',
\  'javascript.jsx',
\  'jsx',
\]
let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" Fuzzy Finder
map <C-p> :GFiles<CR>

" Move Lines
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" JSON
let g:vim_json_syntax_conceal = 0

" Markdown
let g:markdown_fenced_languages = ['html', 'json', 'css', 'javascript', 'elm', 'vim']
autocmd BufNewFile,BufRead *.md set nonu | set spell | set wrap | set lbr | set textwidth=0 | set nolist | set showbreak=↳

" API Blueprint
autocmd BufNewFile,BufRead *.apib set nonu | set spell | set lbr | set textwidth=0 | set nolist | set showbreak=↳
