" Davy Jones vimrc
" Plugins Used {{{
" NERD Commenter - for code commenting
" CTRL P         - for fuzzy searching
" NerdTree       - for Directory Viewing
" Syntastic      - for Syntactic checking
" Lightline      - For cool status bar
" }}}
" Launch Config {{{
runtime! debian.vim
set nocompatible           " make vim act like vim, not vi
call pathogen#infect()     " use pathogen package manager
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
" }}}
" Colours {{{
set t_Co=256
syntax enable
filetype plugin indent on
set background=dark
colorscheme tender
" }}}
" Basic Commands {{{
let mapleader="," " change leader key to comma
set number        " show line number
set showcmd       " show command at bottom of screen
set cursorline    " underline current line
set wildmenu      " helpful command completion with <TAB>
set showmatch     " show matching brackets etc
set ignorecase		" Do case insensitive matching
" }}}
" Tab {{{
set tabstop=2     " tab == 2 spaces
set softtabstop=2
set shiftwidth=2
set expandtab     " tabs are spaces
" }}}
" Searching {{{
set incsearch     " highlight when searching
"set hlsearch      " highlight all matches on search
" }}} 
" Folding {{{
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <TAB> za       
set foldlevelstart=10   " start with fold level of 1
set modelines=1
" }}}
" Key Mapping {{{
let g:ctrlp_map = '<c-p>'  " map CTRL+P to ctrlP for fuzzy searching
let g:ctrlp_cmd = 'CtrlP'  " map CTRL+P to ctrlP for fuzzy searching
:nnoremap å <C-a>
:nnoremap ≈ <C-x>
" }}} 
" Backups {{{
set backup 
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup
" }}}
" AutoGroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
" }}}
" Custom Commands {{{
:command WQ wq          " stop fighting spelling mistakes
:command Wq wq          " stop fighting spelling mistakes
:command W w            " stop fighting spelling mistakes
:command Q q            " stop fighting spelling mistakes 
:cmap w!! w !sudo tee > /dev/null   
" }}}
" NerdTree {{{
let g:NERDTreeWinSize=18 
" }}}
" Lightline {{{ 
" let g:tender_lightline=1
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '  '.branch : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == 'ControlP' ? 'CtrlP' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
" }}}
" NerdCommenter {{{
let g:NERDSpaceDelims = 1       " Add 1 space after comment delimiter
let g:NERDCompactSexyComs = 1   " Use compact style for multi lines
let g:NERDDefaultAlign = 'left' " Don't follow TABS when commenting
" }}}
" Performance   {{{
set noshowmode            " don't show insert at bottom
set ttyfast               " improves smoothness
set laststatus=2          " allow another status line so that airline will work
set wrap linebreak nolist " wrap on words so their not broken
" }}}
" JS Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 3 
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_exec = 'tidy5' " use tidy5 html linter
let g:syntastic_javascript_checkers = ['standard'] " use standard js linter
" }}}
" vim:foldmethod=marker:foldlevel=0
