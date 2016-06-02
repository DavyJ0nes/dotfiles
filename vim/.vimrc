" Davy Jones vimrc
" Plugins Used {{{
" NERD Commenter - for code commenting
" CTRL P         - for fuzzy searching
" Nerd Tree      - for Directory Viewing
" Airline        - For cool status bar
" }}}
" Launch Config {{{
runtime! debian.vim
set nocompatible           " make vim act like vim, not vi
call pathogen#infect()     " use pathogen package manager
" }}}
" Colours {{{
set t_Co=256
syntax enable
filetype plugin indent on
set background=dark
colorscheme hybrid
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
" Airline {{{ 
let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1
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
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}
" vim:foldmethod=marker:foldlevel=0
