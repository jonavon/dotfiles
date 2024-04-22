scriptencoding utf-8
set encoding=utf-8

set guifont="Liberation Mono":h12:cANSI:qDRAFT

map! ^? ^H

inoremap <S-CR> <Esc>
map <Right> :bn<cr>
map <Left> :bp<cr>
map <M-DOWN> <DOWN>.

iab <expr> dts strftime('%Y-%m-%d %H:%M')

let supportDir = "/home/jonavon/Documents/support"

" Change current file to an activity log for today
command! Activity execute 'save' fnameescape(expand('%:p:h') . strftime("/%Y-%m-%d.txt"))
" Create ticket document
command -nargs=1 Support tabe supportDir . "/" . <q-args> . "/" . <q-args> . ".txt"

set backspace=indent,eol,start

set nocompatible
set number
set modeline
set modelines=3
set cursorline

set ruler
set incsearch
set hlsearch
set ignorecase
set showmatch

set nowrap
set noexpandtab
set shiftwidth=2
set tabstop=2
set smarttab
set spell
set list listchars=tab:¤\ ,trail:·,eol:¶,nbsp:¬

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
colorscheme desert
set background=dark
syntax on
highlight SpecialKey term=bold ctermfg=244 ctermbg=236 guifg=#808080 guibg=#343434
highlight NonText term=bold ctermfg=256 ctermbg=256 guifg=#202020 guibg=#202020
highlight CursorLine term=underline cterm=none ctermbg=236 guibg=#444444
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Persistent Backup, Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000
set viminfo=%,<1000,'20,"50,/100,H,f20,n~/vimfiles/_viminfo

"if isdirectory('/var/tmp/vim') == 0
"    :silent !mkdir -p /var/tmp/vim/{backup,swap,undo} > /dev/null 2>&1
"endif

" Backup directory
if isdirectory($HOME . '/.vim/backup') == 0
    :silent !mkdir -p ~/.vim/backup > /dev/null 2>&1
endif
set backupdir=~/.vim/backup//
set backupdir+=./.vim-backup//
set backupdir+=/var/tmp/vim/backup//
set backupdir+=$HOME/vimfiles/tmp/backup//
set backupdir+=.
set backup
"
" swap directory
if isdirectory($HOME . '/.vim/swap') == 0
    :silent !mkdir -p ~/.vim/swap > /dev/null 2>&1
endif
set directory=~/.vim/swap//
set directory+=./.vim-swap//
set directory+=/var/tmp/vim/swap//
set directory+=$HOME/vimfiles/tmp/swap//
set directory+=.
"
" Undo directory
if exists("+undofile")
    if isdirectory($HOME . '/.vim/undo') ==0
        :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
    endif
    set undodir=~/.vim/undo//
    set undodir+=./vim-undo//
    set undodir+=/var/tmp/vim/undo//
    set undodir+=$HOME/vimfiles/tmp/undo//
    set undofile
endif

augroup gzip
    autocmd!
    autocmd BufReadPre,FileReadPre *.gz set bin
    autocmd BufReadPost,FileReadPost   *.gz '[,']!gunzip
    autocmd BufReadPost,FileReadPost   *.gz set nobin
    autocmd BufReadPost,FileReadPost   *.gz execute ":doautocmd BufReadPost " . expand("%:r")
    autocmd BufWritePost,FileWritePost *.gz !mv <afile> <afile>:r
    autocmd BufWritePost,FileWritePost *.gz !gzip <afile>:r
    autocmd FileAppendPre      *.gz !gunzip <afile>
    autocmd FileAppendPre      *.gz !mv <afile>:r <afile>
    autocmd FileAppendPost     *.gz !mv <afile> <afile>:r
    autocmd FileAppendPost     *.gz !gzip <afile>:r
augroup END

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'PProvost/vim-ps1'
Plugin 'Raimondi/delimitMate'
Plugin 'StanAngeloff/php.vim'
Plugin 'bling/vim-airline'
Plugin 'chrisbra/Colorizer'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'ervandew/supertab'
Plugin 'puremourning/vimspector'
Plugin 'kana/vim-bundle'
Plugin 'matchit.zip'
Plugin 'mattn/emmet-vim'
Plugin 'mhinz/vim-startify'
Plugin 'miripiruni/CSScomb-for-Vim'
Plugin 'othree/html5.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-surround'
Plugin 'travisjeffery/vim-auto-mkdir'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
if has('nvim') || version > 900
	Plugin 'exafunction/codeium.vim'
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


let g:table_mode_corner= '|'

"let g:table_mode_corner = '+'
"let g:table_mode_corner_corner ='+'
"let g:table_mode_header_fillchar ='='

"""""""""""""""""""""""""""""""""""""""""""""
" => Vimspector
"""""""""""""""""""""""""""""""""""""""""""""
let g:vimspector_base_dir=expand( '$HOME/.vim/settings/debugger' )
let g:vimspector_enable_mappings='HUMAN'
" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Save files as sudo
cmap w!! w !sudo tee > /dev/null %

" disable insert paste
set clipboard+=unnamed
nnoremap p p`]<Esc>



" vim: set ft=vim :
