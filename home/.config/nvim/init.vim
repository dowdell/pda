scriptencoding utf-8
set encoding=utf-8

call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'editorconfig/editorconfig-vim'
Plug 'moll/vim-node' " use `gf` on `require()`
Plug 'sheerun/vim-polyglot'
  " includes: pangloss/vim-javascript
  " includes: elzr/vim-json
  " includes: elmcast/elm-vim
  " includes: derekwyatt/vim-scala

" Navigation
Plug 'justinmk/vim-dirvish'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'burke/matcher'

" Look and Feel
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'
"Plug 'scrooloose/nerdcommenter'

" Utilities
Plug 'airblade/vim-gitgutter'
Plug 'ruanyl/coverage.vim'
Plug 'geekjuice/vim-mocha' " use `,t` and `,T` to run test suites (mocha and istanbul)
Plug 'w0rp/ale' " lint
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install; and npm install -g tern' }

call plug#end()

" General
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let mapleader=" "
set foldmethod=syntax
set nofoldenable
set ignorecase
set number
set noswapfile
set nowrap
set splitbelow
set splitright
set completeopt=longest,menuone
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set colorcolumn=80
set listchars=tab:▶▶,nbsp:•,extends:»,precedes:«,trail:★
set list

" •  ★ › ▸ ▶ ⁞ Ξ

" auto reload changed files
set autoread
au FocusGained * :checktime

" Gruvbox
set background=dark
"colorscheme gruvbox

" Move Lines
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" remove trailing whitespace in files on save
autocmd BufWritePre * :%s/\s\+$//e

" geekjuice/vim-mocha
let g:mocha_js_command = "split | term npx istanbul cover _mocha -- --recursive {spec}"
:map ,t :w\|:call RunCurrentSpecFile()<cr>
:map ,T :w\|:call RunAllSpecs()<cr>
:map <F4> :!npx mocha --recursive ./src

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

" NERD Commenter
"let g:NERDSpaceDelims = 1
"nmap <C-/> <plug>NERDCommenterToggle

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=238

" CtrlP (with matcher)
let g:path_to_matcher = "/Users/ndowde/.local/share/nvim/site/plugged/matcher/matcher"
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_match_func = { 'match': 'GoodMatch' }

function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

  " Create a cache file if not yet exists
  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
    call writefile(a:items, cachefile)
  endif
  if !filereadable(cachefile)
    return []
  endif

  " a:mmode is currently ignored. In the future, we should probably do
  " something about that. the matcher behaves like "full-line".
  let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
  if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
    let cmd = cmd.'--no-dotfiles '
  endif
  let cmd = cmd.a:str

  return split(system(cmd), "\n")

endfunction

" Ale
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
" •  ★ › ▸ ▶ ⁞ Ξ
" let g:ale_sign_error = '★▸'
let g:ale_sign_error = '▶▶'
let g:ale_linters = {
\  'javascript': [ 'standard' ],
\  'javascript.jsx': [ 'standard' ],
\  'json': ['jsonlint'],
\  'scala': ['scalastyle']
\}

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#filetypes = [
\  'javascript',
\  'javascript.jsx',
\  'jsx',
\]

" Tern
let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
