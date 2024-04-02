" disable incessant beeping
set belloff=all

" set leader to space
let mapleader = "\<Space>"

" utf-8
set encoding=utf-8

" disable modelines
set nomodeline

" number lines
set nu

" tabs to spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" pep8 compliance for python
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix

" incremental search
set incsearch

" highlight search results
set hlsearch

" syntax highlighting
syntax on
filetype plugin indent on
colorscheme slate

" shell
set shell=/bin/bash

" toggles
nmap <C-p> :set invpaste<CR>

" Window split navigation
nmap <TAB> <C-w>
nmap <TAB><TAB> <C-w>w

" neovim redefines Y as yy... which while more correct, conflicts with 30 years 
" of muscle memory.  Make it old-school.
nnoremap Y Y
