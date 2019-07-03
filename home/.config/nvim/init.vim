scriptencoding utf-8
set encoding=utf-8

source ~/.local/share/nvim/site/autoload/setcolors.vim

call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " use `.` for more stuff

" Languages
Plug 'sheerun/vim-polyglot' " includes: pangloss/vim-javascript, elzr/vim-json, elmcast/elm-vim, derekwyatt/vim-scala
Plug 'hashivim/vim-terraform'

" Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish' " use `-` to naviate directories
Plug 'moll/vim-node' " use `gf` on file paths
Plug 'geekjuice/vim-mocha' " use `,t` and `,T` to run test suites (mocha and istanbul)

" Look and Feel
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'powerman/vim-plugin-AnsiEsc'

" Utilities
Plug 'Shougo/deoplete.nvim'
Plug 'carlitux/deoplete-ternjs'
Plug 'w0rp/ale' " lint
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
"let g:ale_sign_error = '››'
let g:coverage_sign_covered = '□'
let g:coverage_sign_uncovered = '■'
set listchars=tab:▸▸,nbsp:•,extends:»,precedes:«,trail:•

" Colors
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=238
colorscheme Benokai
set background=dark " for color scheme
set colorcolumn=80
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:lightline = { 'colorscheme': 'materia' }

" auto reload changed files
autocmd FocusGained * :checktime
set autoread

" remove trailing whitespace in files on save
autocmd BufWritePre * :%s/\s\+$//e

" Ale
"let g:airline#extensions#ale#enabled = 1
"let g:ale_sign_column_always = 1
"let g:ale_linters = {
"\  'javascript': [ 'standard' ],
"\  'javascript.jsx': [ 'standard' ],
"\  'json': ['jsonlint']
"\}

" Code completion, powered by Deoplete and Tern
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#sources#ternjs#filetypes = [
"\  'javascript',
"\  'javascript.jsx',
"\  'jsx',
"\]
"let g:tern_request_timeout = 1
"let g:tern_request_timeout = 6000
"let g:tern#command = ["tern"]
"let g:tern#arguments = ["--persistent"]

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

" Terraform
let g:terraform_fmt_on_save = 1
let g:terraform_align = 1
let g:terraform_fold_sections = 1

" Scala / metals
au BufRead,BufNewFile *.sbt set filetype=scala
"let g:lsc_enable_autocomplete = v:false
"let g:lsc_server_commands = {
"  \ 'scala': 'metals-vim'
"  \}
"let g:lsc_auto_map = {
"  \ 'GoToDefinition': 'gd',
"  \}
