set nocompatible
syntax enable
set number

" Indentation
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

" if hidden not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" always show signcolumns
set signcolumn=yes

" use 256 colors
:set t_Co=256

" fix background color behaviour
hi Normal ctermbg=NONE

" make backspace work like you'd expect in insert mode
:set backspace=indent,eol,start

" use system clipboard as default clipboard
:set clipboard=unnamed

" === Plugins ===
call plug#begin()

try
  source ~/.vimrc.js/vimrc.plugs
  source ~/.vimrc.js/vimrc.plugs.local
catch
endtry

call plug#end()

source ~/.vimrc.js/vimrc.local

" === STATUS/TAB BARS ===

" always show status bar
set laststatus=2
" don't show -- INSERT --, pointless as we have a status bar
set noshowmode

" Initialize lightline config
let g:lightline = {}

" Disable lightline's tab bar
let g:lightline.enable = {'tabline': 0}

" Add lightline-ale components to lightline
let g:lightline.component_expand = {
\  'linter_checking': 'lightline#ale#checking',
\  'linter_warnings': 'lightline#ale#warnings',
\  'linter_errors': 'lightline#ale#errors',
\  'linter_ok': 'lightline#ale#ok'
\ }

" Set colours for the components
let g:lightline.component_type = {
\  'linter_checking': 'left',
\  'linter_warnings': 'warning',
\  'linter_errors': 'error',
\  'linter_ok': 'left'
\ }

" Configure lightline's statusbar
let g:lightline.active = {
\  'left': [[ 'mode', 'paste'], ['readonly', 'relativepath', 'modified']],
\  'right': [
\    ['lineinfo'],
\    ['percent'],
\    ['fileformat', 'fileencoding', 'filetype'],
\	   ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok']
\  ]
\ }

" === Completion ===
let g:ale_completion_enabled = 1

" Use tab to trigger completion and tab/shift-tab to navigate results
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Close preview pane once completion is
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" use ctrl-j, ctrl-k for selecting omni completion entries
inoremap <expr> <C-j> pumvisible() ? '<C-n>' : ''
inoremap <expr> <C-k> pumvisible() ? '<C-p>' : ''

" select omni completion entry with enter (always supress newline)
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

" === LINTING ===
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

" specify some specific ale linter sources, rest are using defaults
let g:ale_linters = {'javascript': ['eslint'], 'typescript': ['eslint']}

" Javascript / React improved highlighting/indentation
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0

" map error jumping to [e and ]e
nnoremap <silent> <Plug>LocationPrevious    :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nnoremap <silent> <Plug>LocationNext        :<C-u>exe 'call <SID>LocationNext()'<CR>
nmap <silent> [e  <Plug>LocationPrevious
nmap <silent> ]e  <Plug>LocationNext
" make error jumping wrap
function! <SID>LocationPrevious()
    try
        lprev
    catch /^Vim\%((\a\+)\)\=:E553/
        llast
    endtry
endfunction
function! <SID>LocationNext()
    try
        lnext
    catch /^Vim\%((\a\+)\)\=:E553/
        lfirst
    endtry
endfunction
