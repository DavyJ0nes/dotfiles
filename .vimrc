" Davy Jones vimrc
" Colours {{{
set t_Co=256
syntax enable
filetype plugin indent on
set background=dark
colorscheme solarized
" }}}
" Basic Commands {{{
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
set expandtab     " tabs are spaces
" }}}
" Searching {{{
set incsearch     " highlight when searching
set hlsearch      " highlight all matches on search
" }}} 
" Folding {{{
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <TAB> za
set foldlevelstart=10    " start with fold level of 1
set modelines=1
" }}}
" Key Mapping {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" }}} 
"   Launch Config {{{
runtime! debian.vim
set nocompatible
call pathogen#infect()
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
:command WQ wq
:command Wq wq
:command W w
:command Q q 
:cmap w!! w !sudo tee > /dev/null %  
" }}}
" Airline {{{
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1
" }}}
" Performance {{{
set noshowmode      " don't show insert at bottom
set ttyfast         " improves smoothness
set laststatus=2    " allow another status line so that airline will work
" }}}
" vim:foldmethod=marker:foldlevel=0
