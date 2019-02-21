scriptencoding utf-8
set encoding=utf-8

source ~/.local/share/nvim/site/autoload/setcolors.vim

call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'moll/vim-node' " use `gf` on file paths
Plug 'sheerun/vim-polyglot'
  " includes: pangloss/vim-javascript
  " includes: elzr/vim-json
  " includes: elmcast/elm-vim
  " includes: derekwyatt/vim-scala
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " use `.` for more stuff

" Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish' " use `-` to naviate directories

" Look and Feel
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ruanyl/coverage.vim'
Plug 'itchyny/lightline.vim'

" Utilities
Plug 'geekjuice/vim-mocha' " use `,t` and `,T` to run test suites (mocha and istanbul)
Plug 'w0rp/ale' " lint
Plug 'Shougo/deoplete.nvim'
Plug 'carlitux/deoplete-ternjs'

call plug#end()

" General
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
let mapleader=" "
set background=dark " for color scheme
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
set colorcolumn=80,120
set listchars=tab:▸▸,nbsp:•,extends:»,precedes:«,trail:•
set list

" •  ★ › ▸ ▶ ⁞ Ξ

let g:lightline = { 'colorscheme': 'jellybeans' }
colorscheme Benokai

" auto reload changed files
set autoread
au FocusGained * :checktime

" remove trailing whitespace in files on save
autocmd BufWritePre * :%s/\s\+$//e

" Fuzzy Finder
map <C-p> :GFiles<CR>

" Move Lines
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_signs = 1

" Coverage
let g:coverage_json_report_path = 'coverage/coverage.raw.json'
let g:coverage_show_covered = 0
let g:coverage_sign_covered = '□'
let g:coverage_show_uncovered = 0
let g:coverage_sign_uncovered = '■'

" JSON
let g:vim_json_syntax_conceal = 0

" Elm
let g:polyglot_disabled = ['elm']
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_syntastic_show_warnings = 1

" Markdown
autocmd BufNewFile,BufRead *.md set nonu | set spell | set wrap | set lbr | set textwidth=0 | set nolist | set showbreak=↳
let g:markdown_fenced_languages = ['html', 'json', 'css', 'javascript', 'elm', 'vim']

" API Blueprint
autocmd BufNewFile,BufRead *.apib set nonu | set spell | set lbr | set textwidth=0 | set nolist | set showbreak=↳

" Vim-Dervish
let g:dirvish_mode = ':sort ,^.*[\/],'

" geekjuice/vim-mocha
let g:mocha_js_command = "split | term npx istanbul cover _mocha -- --recursive {spec}"
:map ,t :w\|:call RunCurrentSpecFile()<cr>
:map ,T :w\|:call RunAllSpecs()<cr>
:map <F4> :!npx mocha --recursive ./src

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=238

" Ale
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
" •  ★ › ▸ ▶ ⁞ Ξ
let g:ale_sign_error = '▶▶'
let g:ale_linters = {
\  'javascript': [ 'standard' ],
\  'javascript.jsx': [ 'standard' ],
\  'json': ['jsonlint'],
\  'scala': ['scalastyle']
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
