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
runtime macros/matchit.vim
filetype off
set nocompatible           " make vim act like vim, not vi
call pathogen#infect()     " use pathogen package manager
call pathogen#helptags()
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
" }}}
" Colours {{{
set laststatus=2      " allow another status line so that airline will work
set t_Co=256
syntax enable
filetype plugin indent on
set background=dark
colorscheme tender
set colorcolumn=+1
hi ColorColumn ctermbg=yellow 
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
au BufRead,BufNewFile Packerfile setfiletype Jenkinsfile
au BufRead,BufNewFile Terraformfile setfiletype Jenkinsfile
au BufRead,BufNewFile *.libsonnet setfiletype .json
" }}}
" Basic Options {{{
let mapleader=","   " change leader key to comma
set number          " enable line numbers
set relativenumber  " use relative line numbers
set showcmd         " show command at bottom of screen
" set cursorline      " underline current line
set wildmenu        " helpful command completion with <TAB>
set showmatch       " show matching brackets etc
set ignorecase		  " Do case insensitive matching
set list            " Adds $ at end of lines
" }}}
" Key Mapping {{{
let g:ctrlp_map = '<c-p>'  " map CTRL+P to ctrlP for fuzzy searching
let g:ctrlp_cmd = 'CtrlP'  " map CTRL+P to ctrlP for fuzzy searching
" paste from clipboard on new line
map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr> 
" set spellcheck on/off
map <leader>son :setlocal spell spelllang=en_gb<cr>
map <leader>soff :set nospell<cr>
" goto file in new window
map gf <c-w>gf
map <leader>nt :tabnew<cr>
" remap increment and decrement numbers to Alt
:nnoremap å <C-a>
:nnoremap ≈ <C-x>
" stop fighting spelling mistakes
:command WQ wq
:command Wq wq
:command W w
:command Q q
" move around panes faster
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
" save faster  
map <leader>q :q<cr>
noremap Z <Esc>:w<CR>
noremap ZZ <Esc>:wq<CR>
" Go-Vim commands
au FileType go nmap <Leader>gd <Plug>(go-doc-tab)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gi <Plug>(go-imports)
" Custom Stuff
:command Date pu=strftime('%d-%m-%Y %H:%M')
:command DDiff w !diff % -
:cmap w!! w !sudo tee > /dev/null   
" }}} 
" Tab {{{
set tabstop=2     " tab == 2 spaces
set softtabstop=2
set shiftwidth=2
set expandtab     " tabs are spaces
" }}}
" Searching {{{
set incsearch     " highlight when searching
set hlsearch      " highlight all matches on search
nmap <leader>h :nohlsearch<cr>
" }}} 
" Windows {{{
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999
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
" Folding {{{
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <TAB> za       
set foldlevelstart=10   " start with fold level of 1
set modelines=1
" }}}
" Performance   {{{
set noshowmode            " don't show insert at bottom
set ttyfast               " improves smoothness
set wrap linebreak nolist " wrap on words so their not broken
set ttimeoutlen=0          " Improve mode shifting speed
" }}}
" NerdTree {{{
let g:NERDTreeWinSize=18 
" }}}
" Lightline {{{ 
" let g:tender_lightline=1
let g:lightline = {
      \ 'colorscheme': 'one',
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
" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 3 
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_exec = 'tidy5' " use tidy5 html linter
let g:syntastic_javascript_checkers = ['eslint'] " use standard js linter
" GO
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
" Ruby
let g:syntastic_ruby_checkers = ['cookstyle', 'rubocop']
let g:syntastic_ruby_rubocop_exec = '/usr/local/bin/cookstyle'
" Python
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_exe = 'python3 -m pylint'

" }}}
" Ansible-vim {{{
let g:ansible_unindent_after_newline = 1
let g:ansible_extra_keywords_highlight = 1
" }}}
" Python {{{
let g:pymode_python = 'python'
" }}}
" Chef-Key-Mapping {{{
nmap <leader>co :ChefFindAnyVsplit<cr>
" }}}
" Terraform {{{
let g:terraform_align=1
let g:terraform_fmt_on_save=1
autocmd FileType terraform setlocal commentstring=#%s
" }}}
" Backups {{{
set backup 
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup
" }}}
" vim:foldmethod=marker:foldlevel=0
